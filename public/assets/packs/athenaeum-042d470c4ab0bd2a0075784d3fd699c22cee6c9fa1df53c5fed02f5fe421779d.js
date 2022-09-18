//caricamento lista di posti
$("#btn_seat").click(function () { 
    $("#main-block").load("./seats #page-div")
    $('#notice').text("")
});

$("#btn_view_reservation").click(function () { 
    $("#main-block").load("./view_reservations #page-div")
    $('#notice').text("")
});

$("#bulletin-board").click(function () { 
    $("#main-block").load("./bulletins #page-div")
    $('#notice').text("")
});
