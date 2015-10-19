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
  var a_prev_next = 'div.prev_next_links > a.btn';

  var escaped_facet_item_value = facet_item_value.replace(/ /g, '+');
  if (event.target.checked) {
    // Insert the facet search term in the search form
    if ($(facet_item_selector).length == 0) {
      $(facet_item_insertion_selector).before(facet_item_element);
    }
    // Insert the facet serch term in the URI
    if ($(a_prev_next).length > 0) {
      add_search_term_to_uri(a_prev_next, encodeURI(facet_item_name + '=' + escaped_facet_item_value));
    }
  } else {
    // Facet search term unchcked - remove from search form
    $(facet_item_selector).remove();
    // Remove facet search term from URI
    if ($(a_prev_next).length > 0) {
      remove_search_term_from_uri(a_prev_next, encodeURI(facet_item_name + '=' + escaped_facet_item_value));
    }
  }

  function add_search_term_to_uri(a_prev_next, term){
    // Extract the href attribute from the link
    var a_href = $(a_prev_next).attr('href');
    // Search term will go before the facet.page parameter
    var facet_page_query = "&facet.page";
    // String position to insert the new search term
    var str_index = a_href.indexOf(facet_page_query);
    // Catenate the new href
    var new_href = a_href.substr(0, str_index) + '&' + term + a_href.substr(str_index);
    // Update the href attribute
    $(a_prev_next).attr('href', new_href);
  }

  function remove_search_term_from_uri(a_prev_next, term){
    // Search term as regular expression
    var term_re = new RegExp(RegExp.escape(term), 'gi')
    // Extract the href attribute from the link
    var a_href = $(a_prev_next).attr('href');
    // Remove the search term
    var new_href = $(a_prev_next).attr('href').replace(term_re, '');
    // Update the href attribute
    $(a_prev_next).attr('href', new_href);
  }
}

RegExp.escape= function(s) {
    return s.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');
};


function multifacet_start_over(event){
  // Clear checkboxes
  $( '.facet-checkbox > input[type="checkbox"]' ).attr('checked', false);
  // Remove hidden fields
  $( 'form.search-query-form > input[type="hidden"][name^="f_inclusive"]').remove();
}
