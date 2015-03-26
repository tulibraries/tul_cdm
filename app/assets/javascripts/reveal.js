$(document).ready(function(){
  // Cannot access thumbnail link directly, must modify DOM
  $(".document-thumbnail a").addClass("triggerWaiting");

  // Trigger wait spinner
  $(".triggerWaiting").click(function(){
    $(".loading").removeClass("hide");
  });
})
