$(document).ready(function(){
    var selected_val = $("input[name='checkCourse']:checked").val();
    console.log(selected_val)

    $("input[type=radio][name=checkCourse]").on("change", function(){
        var valore = $("input[type=radio][name=checkCourse]").val();
        if(this.val != "Categorie"){
            $("#ul-categories").css("display","none");
            console.log(valore);
        }else{
            $("#ul-categories").css("display","block");
            console.log(valore);
        }
    });

    

    

});
