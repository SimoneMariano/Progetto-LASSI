$(document).ready(function(){
    var valore = $("input[type=radio][name=checkCourse]").val();
    console.log(valore)

    $("input[type=radio][name=checkCourse]").on("change", function(){
        var valore = $("input[type=radio][name=checkCourse]").val();
        if(valore != "Categorie"){
            $("#ul-categories").css("display","none");
            console.log(valore);
        }else{
            $("#ul-categories").css("display","block");
            console.log(valore);
        }
    });

    

    

});
