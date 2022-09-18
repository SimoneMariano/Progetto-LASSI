//caricamento catalogo libri da noleggio
$("#btn_library").click(function () { 
    $("#main-block").load("./books #page-div")
    $('#notice').text("")
});

//Caricamento lista di libri presi in prestito 
$("#btn_rental").click(function () { 
    $("#main-block").load("./book_rentals #page-div")
    $('#notice').text("")

});

//Caricamento lista annunci usato 
$("#btn_secondhand").click(function () { 
    $("#main-block").load("./secondhands #page-div")
    $('#notice').text("")

});

//Caricamento lista autori 
$("#btn_aurhors").click(function () { 
    $("#main-block").load("./authors #page-div")
    $('#notice').text("")

});

//Caricamento lista categorie
$("#btn_categories").click(function () { 
    $("#main-block").load("./categories #page-div")
    $('#notice').text("")

});

//Caricamento lista corsi 
$("#btn_courses").click(function () { 
    $("#main-block").load("./courses #page-div")
    $('#notice').text("")

});

$(document).ready(function(){
    $("#ul-categories").css("display","none");

    //mostra le categorie al click
    $("input[type=radio]").on("change", function(){
        var valore = $(this).val()
        if(valore != "Categories"){
            $("#ul-categories").css("display","none");
        }else{
            $("#ul-categories").css("display","block");
        }
    }); 

})
;
