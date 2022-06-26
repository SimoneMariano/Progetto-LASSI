$(document).ready(function(){
    $( "#addCategory" ).on( "click", function() {
        console.log("ok")
        $("#select-div").append($("#book_categories").clone());
    });

    $('#categories').selectpicker();

    $("checkCourse").on("change", function(){
        if($("checkCourse").val() != "Categorie"){
            $("#ul-categories").hide(true)
        }else{
            $("#ul-categories").hide(false)
        }
    })

    

    

});
