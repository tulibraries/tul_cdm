// Copyright(c)2009 Temple University. Software license AGPL version 3.
// Copyright(c)2008-2009 Internet Archive. Software license AGPL version 3.

// Create the BookReader object
br = new BookReader();

// Return the width of a given page.  Here we assume all images are 800 pixels wide
br.getPageWidth = function(index) {
    return parseInt(br.cdmWidth)
}

// Return the height of a given page.  Here we assume all images are 1200 pixels high
br.getPageHeight = function(index) {
    return parseInt(br.cdmHeight)
}

// We load the images from archive.org -- you can modify this function to retrieve images
// using a different URL structure
br.getPageURI = function(index, reduce, rotate) {
    // reduce and rotate are ignored in this simple implementation, but we
    // could e.g. look at reduce and load images from a different directory
    // or pass the information to an image server
    var imgStr = (br.pageList[index]).toString();
    var url = br.cdmArchive;

    //&action=2&DMSCALE=50&DMWIDTH=3000&DMHEIGHT=4000 <-- High res, zoomable but so sloooooow
    url += '/utils/ajaxhelper/?CISOROOT=' + br.cdmColl + '&CISOPTR=' + imgStr + '&action=2&DMSCALE=' + br.cdmScale + '&DMWIDTH=' + br.cdmWidth + '&DMHEIGHT=' + br.cdmHeight;
    return url;
}

// Return which side, left or right, that a given page should be displayed on
br.getPageSide = function(index) {
    if (0 == (index & 0x1)) {
        return 'R';
    } else {
        return 'L';
    }
}

// This function returns the left and right indices for the user-visible
// spread that contains the given index.  The return values may be
// null if there is no facing page or the index is invalid.
br.getSpreadIndices = function(pindex) {
    var spreadIndices = [null, null];
    if ('rl' == this.pageProgression) {
        // Right to Left
        if (this.getPageSide(pindex) == 'R') {
            spreadIndices[1] = pindex;
            spreadIndices[0] = pindex + 1;
        } else {
            // Given index was LHS
            spreadIndices[0] = pindex;
            spreadIndices[1] = pindex - 1;
        }
    } else {
        // Left to right
        if (this.getPageSide(pindex) == 'L') {
            spreadIndices[0] = pindex;
            spreadIndices[1] = pindex + 1;
        } else {
            // Given index was RHS
            spreadIndices[1] = pindex;
            spreadIndices[0] = pindex - 1;
        }
    }

    return spreadIndices;
}

// For a given "accessible page index" return the page number in the book.
//
// For example, index 5 might correspond to "Page 1" if there is front matter such
// as a title page and table of contents.
br.getPageNum = function(index) {
    return index+1;
}

// Redraws the book reader to fit at the current zoom level
//
// Called after switching between embedded and full screen view
br.prepareView = function(mode) {
    switch (mode) {
      case br.constMode1up:
        br.prepareOnePageView();
        break;
      case br.constMode2up:
        br.prepareTwoPageView();
        break;
      case br.constModeThumb:
        br.prepareThumbnailView();
        break;
    }
}

// Custom tool bar
br.initToolbar = function(mode, ui) {
    return; // Disable toolbar
}
// Custom nav bar
br.initNavbar = function() {
    // Setup nav / chapter / search results bar

    $('#BookReader').append(
        '<div id="BRnav">'
        +     '<div id="BRpage">'   // Page turn buttons
        +         '<button class="BRicon onepg"></button>'
        +         '<button class="BRicon twopg"></button>'
        +         '<button class="BRicon thumb"></button>'
        // $$$ not yet implemented
        +         '<button class="BRicon zoom_in"></button>'
        +         '<button class="BRicon zoom_out"></button>'
        +         '<button class="BRicon fit"></button>'
        +         '<button class="BRicon full"></button>'
        +         '<button class="BRicon book_left"></button>'
        +         '<button class="BRicon book_right"></button>'
        +     '</div>'
        +     '<div id="BRnavpos">' // Page slider and nav line
        //+         '<div id="BRfiller"></div>'
        +         '<div id="BRpager"></div>'  // Page slider
        +         '<div id="BRnavline">'      // Nav line with e.g. chapter markers
        +             '<div class="BRnavend" id="BRnavleft"></div>'
        +             '<div class="BRnavend" id="BRnavright"></div>'
        +         '</div>'
        +     '</div>'
        //+     '<div id="BRnavCntlBtm" class="BRnavCntl BRdn"></div>'
        + '</div>'
    );

    var self = this;
    $('#BRpager').slider({
        animate: true,
        min: 0,
        max: this.numLeafs - 1,
        value: this.currentIndex()
    })
    .bind('slide', function(event, ui) {
        self.updateNavPageNum(ui.value);
        $("#pagenum").show();
        return true;
    })
    .bind('slidechange', function(event, ui) {
        self.updateNavPageNum(ui.value); // hiding now but will show later
        $("#pagenum").hide();

        // recursion prevention for jumpToIndex
        if ( $(this).data('swallowchange') ) {
            $(this).data('swallowchange', false);
        } else {
            self.jumpToIndex(ui.value);
        }
        return true;
    })
    .hover(function() {
            $("#pagenum").show();
        },function(){
            // XXXmang not triggering on iPad - probably due to touch event translation layer
            $("#pagenum").hide();
        }
    );

    var jIcons = $('.BRicon');

    jIcons.filter('.fit').bind('click', function(e) {
      br.fitToPage1up();
    });

    jIcons.filter('.full').bind('click', function(e) {
      if ( $('#BookReader').parent().get(0).tagName == 'BODY') {
        $('#wrapper').css('display', 'block');
        $('#BRcontainer').height("640px");
        $('#BookReader').appendTo('#BookReaderContainer');
      } else {
        br_container_height = $(window).height() - $('#BRtoolbar').height() - $('#BRnav').height();
        $('#wrapper').css('display', 'none');
        $('#wrapper').before($('#BookReader'));
        $('#BRcontainer').height(br_container_height);
        $('#BookReader').height("auto");
      }
      br.prepareView(br.mode);
    });


    //append icon to handle
    var handleHelper = $('#BRpager .ui-slider-handle')
    .append('<div id="pagenum"><span class="currentpage"></span></div>');
    //.wrap('<div class="ui-handle-helper-parent"></div>').parent(); // XXXmang is this used for hiding the tooltip?

    this.updateNavPageNum(this.currentIndex());

    $("#BRzoombtn").draggable({axis:'y',containment:'parent'});

    /* Initial hiding
        $('#BRtoolbar').delay(3000).animate({top:-40});
        $('#BRnav').delay(3000).animate({bottom:-53});
        changeArrow();
        $('.BRnavCntl').delay(3000).animate({height:'43px'}).delay(1000).animate({opacity:.25},1000);
    */
}

// resetPageSize
// resets the page sizing for best fit
br.resetPageSize = function() {
    // [NOTE] Workaround: Deallocate _medianPageSize
    // Fixes scaling problem when moving between images of widely varying image sizes
    if (br._medianPageSize) {
      delete br._medianPageSize;
    }

    // reset page to hold best fit
    var autofit = 'height';
    if (br.cdmWidth > br.cdmHeight) {
      autofit = 'width';
    }
    br.onePage = {
        autofit: autofit                                     // valid values are height, width, none
    };

}

br.renderBookreader = function() {
    // Total number of leafs
    br.numLeafs = parseInt($('#page-list').attr('data-leafcount'));

    // Book title and the URL used for the book title link
    br.bookTitle = ($('#page-list').attr('data-cdmTitle'));
    br.bookUrl  = ($('#page-list').attr('data-cdmUrl'));

    // Override the path used to find UI images
    br.imagesBaseURL = '/assets/BookReader/images/';

    // Compound Object Type
    br.cpdType = ($('#page-list').attr('data-cpdtype'));

    br.getEmbedCode = function(frameWidth, frameHeight, viewParams) {
        return "Embed code not supported in bookreader demo.";
    }

    br.pageList = jQuery.parseJSON($('#page-list').attr('data-pageids'));
    br.cdmColl = ($('#page-list').attr('data-cdmcoll'));
    br.cdmNum = ($('#page-list').attr('data-cdmnum'));
    br.cdmArchive = ($('#page-list').attr('data-cdmarchive'));
    br.cdmServer= ($('#page-list').attr('data-cdmserver'));
    br.cdmWidth = ($('#page-list').attr('data-pagewidth'));
    br.cdmHeight = ($('#page-list').attr('data-pageheight'));
    br.cdmScale = ($('#page-list').attr('data-pagescale'));
    br.logoURL = '/'

    br.resetPageSize();

    // Let's go!
    br.init();

    // read-aloud and search need backend compenents and are not supported in the demo
    $('#BRtoolbar').find('.read').hide();
    $('#textSrch').hide();
    $('#btnSrch').hide();
}


br.renderPagereader = function() {
    br.renderBookreader();
    // read-aloud and search need backend compenents and are not supported in the demo
    $('#BRtoolbar').find('.read').hide();
    $('#textSrch').hide();
    $('#btnSrch').hide();
    $('#BRpager').hide();
    $('#BRnavline').hide();
    $('.BRicon.onepg').hide();
    $('.BRicon.twopg').hide();
    $('.BRicon.thumb').hide();
    $('.BRicon.book_left').hide();
    $('.BRicon.book_right').hide();
}

// Get autofit factor for given dimension
// reductionFactors should be array of sorted reduction factors
// e.g. [ {reduce: 0.25, autofit: null}, {reduce: 0.3, autofit: 'width'}, {reduce: 1, autofit: null} ]
// autoFit should be a string indicating the dimension of autofit either 'width' or 'height'
br.getAutoFitIndex = function(reductionFactors, autoFitDimension) {
    for (var i = 0; i < reductionFactors.length; i++) {
        if (reductionFactors[i].autofit == autoFitDimension)
          return i;
    }
    return -1;
}

// Get the reduction index for the desired scale
br.getReductionIndex = function(reductionFactors, scale) {
    for (var i = 0; i < reductionFactors.length; i++) {
        if (reductionFactors[i].reduce == scale)
          return i;
    }
    return -1;
}

// Fit to page
br.fitToPage1up = function() {
    // Determine which autofit scale, use the longest dimension of height or width
    var autofitHeightIndex = br.getAutoFitIndex(br.onePage.reductionFactors, 'height');
    var autofitWidthIndex = br.getAutoFitIndex(br.onePage.reductionFactors, 'width');
    if ((autofitWidthIndex < 0) && (autofitHeightIndex < 0))
      return;
    var autofitScale = (autofitHeightIndex > autofitWidthIndex) ? autofitHeightIndex : autofitWidthIndex;

    // Get the index in the reduction factor arraty for the autofit scale to use
    var reductionIndex = br.getReductionIndex(br.onePage.reductionFactors, br.reduce);
    if (reductionIndex < 0)
      return;

    if (reductionIndex != autofitScale) {
      // Determine which direction we are zooming
      var direction = (reductionIndex < autofitScale) ? -1 : 1;

      // How many zoom steps we need to go
      var steps = Math.abs(autofitScale - reductionIndex);

      // Zoom to the autofit scale
      for (var i = 0; i < steps; i++) {
        br.zoom(direction);
      }
    }
}
