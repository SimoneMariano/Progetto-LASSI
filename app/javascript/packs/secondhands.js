$(document).ready(function(){
    $("#ul-categories").css("display","none");

    //mostra le categorie al click
    $("input[type=radio][name=checkCourse]").on("change", function(){
        var valore = $(this).val()
        if(valore != "Categorie"){
            $("#ul-categories").css("display","none");
        }else{
            $("#ul-categories").css("display","block");
        }
    }); 

})
