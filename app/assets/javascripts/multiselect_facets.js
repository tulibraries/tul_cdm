$(document).ready(function() {
  $( '.facet-checkbox > input[type="checkbox"]' ).click(function(event){
    click_multifacet(event);
  });

  $( '.multifacet-start-over' ).click(function(event){
    multifacet_start_over(event);
  });
});

// Add ajax modal trigger
Blacklight.ajaxModal.triggerLinkSelector  += ",a.more_multiselect_facets_link";

// Handles multifacet by adding the hidden search term field field to search form
function click_multifacet(event){
  var facet_item_value = event.target.value;
  var facet_item_name = event.target.name;
  var facet_item_selector = 'form.search-query-form > input[type="hidden"][name="' + facet_item_name + '"][value="' + facet_item_value + '"]';
  var facet_item_element = '<input name="' + facet_item_name + '" type="hidden" value="' + facet_item_value + '">'
  var facet_item_insertion_selector = 'form.search-query-form > div.input-group';

  if (event.target.checked) {
    if ($(facet_item_selector).length == 0) {
      $(facet_item_insertion_selector).before(facet_item_element);
    }
  }
  else {
    $(facet_item_selector).remove();
  }
}


function multifacet_start_over(event){
  // Clear checkboxes
  $( '.facet-checkbox > input[type="checkbox"]' ).attr('checked', false);
  // Remove hidden fields
  $( 'form.search-query-form > input[type="hidden"][name^="f_inclusive"]').remove();
}
