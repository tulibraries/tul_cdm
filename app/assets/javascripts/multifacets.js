$(document).ready(function(){
  resetFacets();
})

function resetFacets(){
  $("input[type='hidden'][name='f_inclusive[digital_collection_sim][]']").remove();
}

Blacklight.ajaxModal.triggerLinkSelector  += ",a.more_multiselect_facets_link";
