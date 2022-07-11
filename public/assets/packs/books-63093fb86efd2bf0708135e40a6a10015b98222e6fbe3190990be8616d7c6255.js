$(document).ready(function(){
    $( "#addCategory" ).on( "click", function() {
        console.log("ok")
        $("#select-div").append($("#categories").clone());
    });

    $(".chosen-select").chosen({
        no_results_text: "Oops, nothing found!"
      })
});
