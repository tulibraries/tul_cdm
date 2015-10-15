$(document).ready(function() {
  $( 'form [type="checkbox"]' ).click(function(event){
    click_multifacet(event)
  });
});

function click_multifacet(event){
    var facet_item = event.target.value
    var facet_name = event.target.name
    var checked = event.target.checked
    var selector = 'form.search-query-form > input[type="hidden"][name="' + facet_name + '"][value="' + facet_item + '"]'

    if (!checked) {
      console.log(facet_item + " unchecked");
      $(selector).remove;
    }

}

