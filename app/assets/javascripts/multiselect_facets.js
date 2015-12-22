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
  var a_more_link = 'a.more_multiselect_facets_link';
  var sidebar_checkbox_selector = 'input[type="checkbox"][value="' + facet_item_value + '"]';

  if (event.target.checked) {
    // Insert the facet search term in the search form
    if ($(facet_item_selector).length == 0) {
      $(facet_item_insertion_selector).before(facet_item_element);
    }
    // Insert the facet search term to the more link
    if ($(a_more_link).length > 0) {
      add_search_term_to_uri(a_more_link, facet_item_name, facet_item_value);
    }
    // For paginated list
    if ($(a_prev_next).length > 0) {
      add_search_term_to_uri(a_prev_next, facet_item_name, facet_item_value);
      $(sidebar_checkbox_selector).prop('checked', 'checked');
    }
  } else {
    // Facet search term unchcked - remove from search form
    $(facet_item_selector).remove();
    // Insert the facet search term to the more link
    if ($(a_more_link).length > 0) {
      remove_search_term_from_uri(a_more_link, facet_item_name, facet_item_value);
    }
    // For paginated list
    if ($(a_prev_next).length > 0) {
      remove_search_term_from_uri(a_prev_next, facet_item_name, facet_item_value);
      $(sidebar_checkbox_selector).prop('checked', '');
    }
  }

  function add_search_term_to_uri(selector, facet_item_name, facet_item_value){
    var term = encodeURI(facet_item_name + '=' + facet_item_value.replace(/ /g, '+'));
    var a_href = $(selector).attr('href');
    var link = a_href.split("?");
    var query = term;

    if (link.length > 1) {
      query += '&' + link[1];
    }

    var new_href = link[0] + '?' + query;

    return encodeURI($(selector).attr('href', new_href));
  }

  function remove_search_term_from_uri(selector, facet_item_name, facet_item_value){
    var term = encodeURI(facet_item_name + '=' +  facet_item_value.replace(/ /g, '+'));
    var a_href = $(selector).attr('href');
    var link = a_href.split("?");
    var new_href = link[0];

    if (link.length > 1) {
      var queries = link[1].split("&");
      // Remove the search term
      queries.splice(queries.indexOf(term), 1);

      // Append queries if there are any left
      if (queries.length > 0) {
        new_href += '?' + queries.join("&");
      }
    }

    return $(selector).attr('href', new_href);
  }
}

function multifacet_start_over(event){
  // Clear checkboxes
  $( '.facet-checkbox > input[type="checkbox"]' ).attr('checked', false);
  // Remove hidden fields
  $( 'form.search-query-form > input[type="hidden"][name^="f_inclusive"]').remove();
}
