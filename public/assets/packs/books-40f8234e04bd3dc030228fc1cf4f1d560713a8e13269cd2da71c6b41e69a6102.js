$(document).ready(function(){


    $("checkCourse").on("change", function(){
        if($("checkCourse").val() != "Categorie"){
            $("#ul-categories").hide()
        }else{
            $("#ul-categories").show()
        }
    })

    

    

});
