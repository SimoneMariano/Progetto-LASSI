$(document).ready(function(){
    $("#ul-categories").css("display","none");

    $("input[type=radio][name=checkCourse]").on("change", function(){
        var valore = $(this).val()
        if(valore != "Categorie"){
            $("#ul-categories").css("display","none");
            console.log(valore);
        }else{
            $("#ul-categories").css("display","block");
            console.log(valore);
        }
    });

    

    

})