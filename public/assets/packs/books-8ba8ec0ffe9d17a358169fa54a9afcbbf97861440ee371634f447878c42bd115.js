let Add_select = $("#add_category").click(function(){
    alert("ok")
    $("#categories").clone().appendTo("#select-div");
});

$(Add_select.setup);
