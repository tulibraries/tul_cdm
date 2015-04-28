$(document).ready(function(){
  $(".downloadTrigger").click(function(event){
    var target = $( event.target );
    var filename = target.attr("target");
    var ocr_text = $("#document-content-viewer").text();
    var blob = new Blob([ocr_text], {type: "text/plain;charset=utf-8"});
    saveAs(blob, filename);
  });
})
