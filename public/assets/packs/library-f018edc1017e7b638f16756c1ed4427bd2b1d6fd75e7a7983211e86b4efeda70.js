//caricamento catalogo libri da noleggio
$("#btn_library").click(function () { 
    $("#main-block").load("./books #page-div")
});

//Caricamento lista di libri presi in prestito 
$("#btn_rental").click(function () { 
    $("#main-block").load("./book_rentals #page-div")
});

//Caricamento lista annunci usato 
$("#btn_secondhand").click(function () { 
    $("#main-block").load("./secondhands #page-div")
});

//Caricamento lista autori 
$("#btn_aurhors").click(function () { 
    $("#main-block").load("./authors #page-div")
});

//Caricamento lista categorie
$("#btn_categories").click(function () { 
    $("#main-block").load("./categories #page-div")
});

//Caricamento lista corsi 
$("#btn_courses").click(function () { 
    $("#main-block").load("./courses #page-div")
});

