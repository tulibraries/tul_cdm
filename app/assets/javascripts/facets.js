$(document).ready(function() {
  
});

function openFacets(){
    $('div.sort-by-facets h5').removeClass('twiddle-open');
    $('div.sort-by-facets ul').hide();
    
    $('div.sort-by-facets h5').addClass('twiddle-open');
    $('div.sort-by-facets ul').show();
    
    $('div.narrow-by-facets-open h5').removeClass('twiddle-open');
    $('div.narrow-by-facets-open ul').hide(); 
    
    $('div.narrow-by-facets-open h5').addClass('twiddle-open');
    $('div.narrow-by-facets-open ul').show(); 
}

