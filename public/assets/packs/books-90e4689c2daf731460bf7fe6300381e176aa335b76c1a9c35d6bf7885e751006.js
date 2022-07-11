$(document).ready(function(){
    $( "#addCategory" ).on( "click", function() {
        console.log("ok")
        $("#select-div").append($("#categories").clone());
    });

    $('#categories').selectpicker();

    

});
