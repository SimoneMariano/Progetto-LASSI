$(document).ready(function(){
    var selected_val = $("input[name='checkCourse']:checked").val();
    console.log(selected_val)

    $("input[type=radio][name=checkCourse]").on("change", function(){
        var selected_val = $("input[name='checkCourse']:checked").val();
        if(this.val != "Categorie"){
            $("#ul-categories").css("display","none");
            console.log("categorie non");
        }else{
            $("#ul-categories").css("display","block");
            console.log("categorie");
        }
    });

    

    

});
