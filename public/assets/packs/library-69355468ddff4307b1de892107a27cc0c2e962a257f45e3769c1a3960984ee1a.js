//caricamento catalogo libri da noleggio




$(document).ready(function() {
    function deferredLoad(target, url) {
        return $.Deferred(function(deferred) {
            $(target).load(url, function() {
                deferred.resolve();
            });
        }).promise();
    }

    var loadPromises = [];

    $("#btn_library").click(function () { 
        loadPromises.push(deferredLoad('#main-block', './books #page-div'));
        $('#notice').text("")
    });
    
    //Caricamento lista di libri presi in prestito 
    $("#btn_rental").click(function () { 
        loadPromises.push(deferredLoad('#main-block', './book_rentals #page-div'));
        $('#notice').text("")
    
    });
    
    //Caricamento lista annunci usato 
    $("#btn_secondhand").click(function () { 
        loadPromises.push(deferredLoad('#main-block', './secondhands #page-div'));
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

    $.when.apply(null, loadPromises).done(function() {
        console.log("ciao");
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
    });


});
