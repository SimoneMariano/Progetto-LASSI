$(document).ready(function(){
    var selected_val = $("checkCourse option:selected").val();
    console.log(selected_val)

    $("checkCourse").on("change", function(){
        var selected_val = $("checkCourse option:selected").val();
        if(selected_val != "Categorie"){
            $("#ul-categories").css("display","none");
            console.log(selected_val);
        }else{
            $("#ul-categories").css("display","block");
            console.log(selected_val);
        }
    });

    

    

});
