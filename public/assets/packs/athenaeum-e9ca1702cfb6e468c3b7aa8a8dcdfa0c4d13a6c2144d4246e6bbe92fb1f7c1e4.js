//caricamento lista di posti
$("#btn_seat").click(function () { 
    $("#main-block").load("./seats #page-div")
    $('#notice').text("")
});

$("#btn_view_reservation").click(function () { 
    $("#main-block").load("./view_reservations")
    $('#notice').text("")
});
