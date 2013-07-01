$('#login-submit').click(function () {
    $(this).button('loading');
    $('.alert').remove();
    var username = $('#usernamel');
    var user_p = username.parents('.row');
    user_p.removeClass().addClass("row");
    var password = $('#passwordl');
    var pas_p = password.parents(".row");
    pas_p.removeClass().addClass("row");
    var non_pass;
    if (!(username[0].value)) {
        non_pass = $('<div></div>').addClass("alert").text("用户名不能为空");
        username.after(non_pass);
        $(this).button('reset');
        user_p.addClass("has-error");
    }
    else if (!(password[0].value)) {
        non_pass = $('<div></div>').addClass("alert").text("密码不能为空");
        password.after(non_pass);
        $(this).button('reset');
        pas_p.addClass("has-error");
    }
    else {
        $.ajax({
            type: "POST",
            url: "http://seekpro.in/users",
            data: { username: username[0].value, password: password[0].value }
        }).done(function (msg) {
            });

    }

});