//caricamento catalogo libri da noleggio
$("#btn_reservation").click(function () { 
    $("#main-block").load("./reservation #page-div")
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
