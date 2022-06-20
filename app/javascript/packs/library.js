//caricamento catalogo libri da noleggio
$("#btn1").click(function () { 
    $("#main-block").load("./books")
});

//Caricamento lista di libri presi in prestito
$("#btn1").click(function () { 
    $("#main-block").load("./btn_rental")
});

