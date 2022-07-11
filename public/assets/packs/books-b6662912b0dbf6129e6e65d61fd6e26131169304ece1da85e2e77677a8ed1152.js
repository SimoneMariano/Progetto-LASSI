$(document).ready(function(){
    $( "#addCategory" ).on( "click", function() {
        console.log("ok")
        $("#select-div").append($("#categories").clone());
    });

    $('.js-example-basic-multiple').select2();
});
