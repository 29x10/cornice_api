$('#login-submit').click(function (event) {
    event.preventDefault();
    $(this).button('loading');
    $('.alert').remove();
    var username = $('#usernamel');
    var user_p = username.parents('.login-row.row');
    user_p.removeClass('has-error')
    var password = $('#passwordl');
    var pas_p = password.parents(".login-row.row");
    pas_p.removeClass('has-error')
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
            crossDomain: true,
            dataType: 'json',
            data: { username: username[0].value, password: password[0].value }
        }).done(function (msg) {
                if (msg.token){
                    $.cookie.raw = true;
                    $.cookie('auth_tkt', msg.token, { expires: 1, path: '/' });
                    $('#loginModal').modal('hide');
                    $('#login-submit').button('reset');
                    location.reload();
                }
            }).fail(function (msg) {
                if (msg.responseJSON.status && msg.responseJSON.status == "error") {
                    if (msg.responseJSON.errors) {
                        msg.responseJSON.errors.forEach(function (error) {
                            if (/not_none/g.test(error.name)) {
                                non_pass = $('<div></div>').addClass("alert").text(error.description);
                                password.after(non_pass);
                                $('#login-submit').button('reset');
                                user_p.addClass("has-error");
                                pas_p.addClass("has-error");
                            }
                            if (/password_not_match/g.test(error.name)) {
                                non_pass = $('<div></div>').addClass("alert").text(error.description);
                                password.after(non_pass);
                                $('#login-submit').button('reset');
                                pas_p.addClass("has-error");
                            }
                            if (/username_not_exist/g.test(error.name)) {
                                non_pass = $('<div></div>').addClass("alert").text(error.description);
                                username.after(non_pass);
                                $('#login-submit').button('reset');
                                user_p.addClass("has-error");
                            }
                        });
                    }
                }
            });
    }
});