$(document).ready(function(){
    $( "#addCategory" ).on( "click", function() {
        console.log("ok")
        alert("ok")
        $("#categories").clone().appendTo("#addCategory");
    });
});
