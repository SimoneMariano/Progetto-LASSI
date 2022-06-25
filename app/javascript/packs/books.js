$(document).ready(function(){
    $( "#addCategory" ).on( "click", function() {
        console.log("ok")
        $("#select-div").append($("#book_categories").clone());
    });

    $('#categories').selectpicker();

    

})