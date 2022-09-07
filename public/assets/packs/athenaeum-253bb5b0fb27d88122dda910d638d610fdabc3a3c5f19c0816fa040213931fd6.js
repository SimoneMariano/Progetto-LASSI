//caricamento lista di posti
$("#btn_seat").click(function () { 
    $("#main-block").load("./seats #page-div")
    $('#notice').text("")
});
