//caricamento lista di posti
$("#btn_seat").click(function () { 
    $("#main-block").load("./seats #page-div")
    $('#notice').text("")
});

$("#btn_reservation").click(function () { 
    $("#main-block").load("./reservations #page-div")
    $('#notice').text("")
});

$("#bulletin-board").click(function () { 
    $("#main-block").load("./bulletins #page-div")
    $('#notice').text("")
});
