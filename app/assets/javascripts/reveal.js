$(document).ready(function(){
  // Cannot access thumbnail link directly, must modify DOM
  $(".document-thumbnail a").addClass("triggerWaiting");

  // Trigger wait spinner
  $(".triggerWaiting").click(function(event){
    target = $( event.target );
    if (target.is( "img" ) ) {
      spinner = $(this).parent().siblings(".row").find(".loading");
    } else {
      spinner = $(this).siblings(".loading");
    }
    spinner.removeClass("hide");
  });
})
