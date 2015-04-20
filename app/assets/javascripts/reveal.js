$(document).ready(function(){
  // Cannot access thumbnail link directly, must modify DOM
  $(".document-thumbnail a").addClass("triggerWaiting");

  // Trigger wait spinner
  $(".triggerWaiting").click(function(){
    item = $( this ).parents(".row").first();

    $(this).siblings(".loading").removeClass("hide");
  });
})
