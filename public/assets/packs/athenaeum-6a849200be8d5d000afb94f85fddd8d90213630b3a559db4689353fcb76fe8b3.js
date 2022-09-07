//caricamento lista di posti
$("#btn_seat").click(function () { 
    $("#main-block").load("./seats #page-div")
    $('#notice').text("")
});

$("#btn_seat").click(function () { 
    $("#main-block").load("./view_reservation #page-div")
    $('#notice').text("")
});
