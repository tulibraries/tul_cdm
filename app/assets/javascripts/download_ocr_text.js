$(document).ready(function(){
  // Trigger download
  $(".downloadTrigger").click(function(event){
    window.open("data:text/plain;charset=utf-8," + escape($("#document-content-viewer").text()));
  });
})
