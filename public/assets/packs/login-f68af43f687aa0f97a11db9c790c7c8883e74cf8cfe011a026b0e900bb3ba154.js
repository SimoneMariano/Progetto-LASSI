$("#student-login").load("./users/sign_in #student-link");
$("#login-form").on("click", function() {
    let form = document.getElementById("login-form");
    form.submit(); 
});
