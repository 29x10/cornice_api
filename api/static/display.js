$('#login-submit').click(function (event) {
    event.preventDefault();
    $(this).button('loading');
    $('.alert').remove();
    var username = $('#usernamel');
    var user_p = username.parents('.login-row.row');
    user_p.removeClass('has-error');
    var password = $('#passwordl');
    var pas_p = password.parents(".login-row.row");
    pas_p.removeClass('has-error');
    var non_pass;
    if (!(username[0].value)) {
        non_pass = $('<div></div>').addClass("alert").text("用户名不能为空");
        username.after(non_pass);
        $(this).button('reset');
        user_p.addClass("has-error");
    }
    else if (!(/[A-Za-z][\w.-]*/g.test(username[0].value)) || (username[0].value.length > 31)) {
        var error_pass = $('<div></div>').addClass("alert").text("用户名只能以英文字母开头，其余为英文、数字、点、减号和下划线，且不能超过30个字符");
        username.after(error_pass);
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
            url: "/users",
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
                else {
                    $('#login-submit').button('reset');
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
                            if (/password_error/g.test(error.name)) {
                                var password_error = $('<div></div>').addClass("alert").text(error.description);
                                password.after(password_error);
                                $('#login-submit').button('reset');
                                pas_p.addClass("has-error");
                            }
                            if (/username_not_exist/g.test(error.name)) {
                                var user_not_exist = $('<div></div>').addClass("alert").text(error.description);
                                username.after(user_not_exist);
                                $('#login-submit').button('reset');
                                user_p.addClass("has-error");
                            }
                            if (/username_invalid/g.test(error.name)) {
                                var user_invalid = $('<div></div>').addClass("alert").text(error.description);
                                username.after(user_invalid);
                                $('#login-submit').button('reset');
                                user_p.addClass("has-error");
                            }
                        });
                    }
                    else {
                        $('#login-submit').button('reset');
                    }
                }
                else {
                    $('#login-submit').button('reset');
                }
            });
    }
});


$('#signup-submit').click(function (event) {
    event.preventDefault();
    $(this).button('loading');
    $('.alert').remove();
    var username = $('#usernames');
    var user_p = username.parents('.signup-row.row');
    user_p.removeClass('has-error');
    var password1 = $('#password1s');
    var pas1_p = password1.parents(".signup-row.row");
    pas1_p.removeClass('has-error');
    var password2 = $('#password2s');
    var pas2_p = password2.parents(".signup-row.row");
    pas2_p.removeClass('has-error');
    var non_pass;
    if (!(username[0].value)) {
        non_pass = $('<div></div>').addClass("alert").text("用户名不能为空");
        username.after(non_pass);
        $(this).button('reset');
        user_p.addClass("has-error");
    }
    else if (!((/[A-Za-z][\w.-]*/g.test(username[0].value)) && (username[0].value.length < 31))) {
        var error_pass = $('<div></div>').addClass("alert").text("用户名只能以英文字母开头，其余为英文、数字、点、减号和下划线，且不能超过30个字符");
        username.after(error_pass);
        $(this).button('reset');
        user_p.addClass("has-error");
    }
    else if (!(password1[0].value)) {
        non_pass = $('<div></div>').addClass("alert").text("密码不能为空");
        password1.after(non_pass);
        $(this).button('reset');
        pas1_p.addClass("has-error");
    }
    else if (!(password2[0].value)) {
        non_pass = $('<div></div>').addClass("alert").text("密码不能为空");
        password2.after(non_pass);
        $(this).button('reset');
        pas2_p.addClass("has-error");
    }
    else if (password1[0].value !== password2[0].value) {
        var mismatch = $('<div></div>').addClass("alert").text("两次密码不一致");
        password2.after(mismatch);
        $(this).button('reset');
        pas2_p.addClass("has-error");
    }
    else {
        $.ajax({
            type: "POST",
            url: "/users/create",
            dataType: 'json',
            data: { username: username[0].value, password: password1[0].value, password_confirm: password2[0].value }
        }).done(function (msg) {
                if (msg.token){
                    $.cookie.raw = true;
                    $.cookie('auth_tkt', msg.token, { expires: 1, path: '/' });
                    $('#signupModal').modal('hide');
                    $('#signup-submit').button('reset');
                    location.reload();
                }
                else {
                    $('#signup-submit').button('reset');
                }
            }).fail(function (msg) {
                if (msg.responseJSON.status && msg.responseJSON.status == "error") {
                    if (msg.responseJSON.errors) {
                        msg.responseJSON.errors.forEach(function (error) {
                            if (/not_none/g.test(error.name)) {
                                non_pass = $('<div></div>').addClass("alert").text(error.description);
                                password2.after(non_pass);
                                $('#signup-submit').button('reset');
                                user_p.addClass("has-error");
                                pas1_p.addClass("has-error");
                                pas2_p.addClass("has-error");
                            }
                            if (/username_exist/g.test(error.name)) {
                                var user_exist = $('<div></div>').addClass("alert").text(error.description);
                                username.after(user_exist);
                                $('#signup-submit').button('reset');
                                user_p.addClass("has-error");
                            }
                            if (/username_invalid/g.test(error.name)) {
                                var user_invalid = $('<div></div>').addClass("alert").text(error.description);
                                username.after(user_invalid);
                                $('#signup-submit').button('reset');
                                user_p.addClass("has-error");
                            }
                            if (/password_mismatch/g.test(error.name)) {
                                var password_mismatch = $('<div></div>').addClass("alert").text(error.description);
                                username.after(password_mismatch);
                                $('#signup-submit').button('reset');
                                pas2_p.addClass("has-error");
                            }
                        });
                    }
                    else {
                        $('#signup-submit').button('reset');
                    }
                }
                else {
                    $('#signup-submit').button('reset');
                }
            });
    }
});

$('#logout').click(function (event) {
    event.preventDefault();
    $.cookie.raw = true;
    var token = $.cookie('auth_tkt');
    $.ajax({
        type: 'GET',
        url: '/users?token=' + token,
        dataType: 'json'
    }).done(function (msg) {
            $.removeCookie('auth_tkt');
            location.reload();
        }).fail(function (msg) {
            $.removeCookie('auth_tkt');
            location.reload();
        });
});