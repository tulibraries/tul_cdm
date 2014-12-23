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

    //&action=2&DMSCALE=50&DMWIDTH=3000&DMHEIGHT=4000 <-- High res, zoomable but so sloooooow
    var url = br.cdmArchive + '/utils/ajaxhelper/?CISOROOT=' + br.cdmColl + '&CISOPTR=' + imgStr + '&action=2&DMSCALE=' + br.cdmScale + '&DMWIDTH=' + br.cdmWidth + '&DMHEIGHT=' + br.cdmHeight;
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

// Custom tool bar
br.initToolbar = function(mode, ui) {

    if (ui == "embed") {
        return; // No toolbar at top in embed mode
    }

    // $$$mang should be contained within the BookReader div instead of body
    var readIcon = '';
    if (!navigator.userAgent.match(/mobile/i)) {
        readIcon = "<button class='BRicon read modal'></button>";
    }

    $("#BookReader").append(
          "<div id='BRtoolbar'>"
        +   "<span id='BRtoolbarbuttons'>"
        //+     "<form action='javascript:br.search($(\"#textSrch\").val());' id='booksearch'><input type='search' id='textSrch' name='textSrch' val='' placeholder='Search inside'/><button type='submit' id='btnSrch' name='btnSrch'>GO</button></form>"
        +     "<button class='BRicon play'></button>"
        +     "<button class='BRicon pause'></button>"
        //+     "<button class='BRicon info'></button>"
        //+     "<button class='BRicon share'></button>"
        //+     readIcon
        //+     "<button class='BRicon full'></button>"
        +   "</span>"
        +   "<span><a class='logo' href='" + this.logoURL + "'></a></span>"
        +   "<span id='BRreturn'><a></a></span>"
        +   "<div id='BRnavCntlTop' class='BRnabrbuvCntl'></div>"
        + "</div>"
        /*
        + "<div id='BRzoomer'>"
        +   "<div id='BRzoompos'>"
        +     "<button class='BRicon zoom_out'></button>"
        +     "<div id='BRzoomcontrol'>"
        +       "<div id='BRzoomstrip'></div>"
        +       "<div id='BRzoombtn'></div>"
        +     "</div>"
        +     "<button class='BRicon zoom_in'></button>"
        +   "</div>"
        + "</div>"
        */
        );

    // Browser hack - bug with colorbox on iOS 3 see https://bugs.launchpad.net/bookreader/+bug/686220
    if ( navigator.userAgent.match(/ipad/i) && $.browser.webkit && (parseInt($.browser.version, 10) <= 531) ) {
       $('#BRtoolbarbuttons .info').hide();
       $('#BRtoolbarbuttons .share').hide();
    }

    $('#BRreturn a').attr('href', this.bookUrl).text(this.bookTitle);

    $('#BRtoolbar .BRnavCntl').addClass('BRup');
    $('#BRtoolbar .pause').hide();

    this.updateToolbarZoom(this.reduce); // Pretty format

    if (ui == "embed" || ui == "touch") {
        $("#BookReader a.logo").attr("target","_blank");
    }

    // $$$ turn this into a member variable
    var jToolbar = $('#BRtoolbar'); // j prefix indicates jQuery object

    // We build in mode 2
    jToolbar.append();

    // Hide mode buttons and autoplay if 2up is not available
    // $$$ if we end up with more than two modes we should show the applicable buttons
    if ( !this.canSwitchToMode(this.constMode2up) ) {
        jToolbar.find('.two_page_mode, .play, .pause').hide();
    }
    if ( !this.canSwitchToMode(this.constModeThumb) ) {
        jToolbar.find('.thumbnail_mode').hide();
    }

    // Hide one page button if it is the only mode available
    if ( ! (this.canSwitchToMode(this.constMode2up) || this.canSwitchToMode(this.constModeThumb)) ) {
        jToolbar.find('.one_page_mode').hide();
    }

    // $$$ Don't hardcode ids
    var self = this;
    jToolbar.find('.share').colorbox({inline: true, opacity: "0.5", href: "#BRshare", onLoad: function() { self.autoStop(); self.ttsStop(); } });
    jToolbar.find('.info').colorbox({inline: true, opacity: "0.5", href: "#BRinfo", onLoad: function() { self.autoStop(); self.ttsStop(); } });

    $('<div style="display: none;"></div>').append(this.blankShareDiv()).append(this.blankInfoDiv()).appendTo($('body'));

    $('#BRinfo .BRfloatTitle a').attr( {'href': this.bookUrl} ).text(this.bookTitle).addClass('title');

    // These functions can be overridden
    this.buildInfoDiv($('#BRinfo'));
    this.buildShareDiv($('#BRshare'));

    // Switch to requested mode -- binds other click handlers
    //this.switchToolbarMode(mode);

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
        //+         '<button class="BRicon fit"></button>'
        +         '<button class="BRicon zoom_in"></button>'
        +         '<button class="BRicon zoom_out"></button>'
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

br.renderBookreader = function() {
    // Total number of leafs
    br.numLeafs = parseInt($('#page-list').attr('data-leafcount'));

    // Book title and the URL used for the book title link
    br.bookTitle = ($('#page-list').attr('data-cdmTitle'));
    br.bookUrl  = ($('#page-list').attr('data-cdmUrl'));

    // Override the path used to find UI images
    br.imagesBaseURL = '/assets/BookReader/images/';

    br.getEmbedCode = function(frameWidth, frameHeight, viewParams) {
        return "Embed code not supported in bookreader demo.";
    }

    br.pageList = jQuery.parseJSON($('#page-list').attr('data-pageids'));
    br.cdmColl = ($('#page-list').attr('data-cdmcoll'));
    br.cdmArchive = ($('#page-list').attr('data-cdmarchive'));
    br.cdmServer= ($('#page-list').attr('data-cdmserver'));
    br.cdmWidth = ($('#page-list').attr('data-pagewidth'));
    br.cdmHeight = ($('#page-list').attr('data-pageheight'));
    br.cdmScale = ($('#page-list').attr('data-pagescale'));
    br.logoURL = '/'

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
