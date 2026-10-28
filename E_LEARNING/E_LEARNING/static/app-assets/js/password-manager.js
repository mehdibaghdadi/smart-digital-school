var tooglePassword = function (id_pass, id_eye) {
    var type = $(id_pass).attr('type') == 'password' ? "text" : 'password';
    $(id_pass).attr('type', type)
    $(id_eye).toggleClass("fa-eye-slash").toggleClass("fa-eye");
}

var passwordGenerator = function () {
    var passwordLength = 9;
    var upperGen = true;
    var numbersGen = false;
    var symbolsGen = false;

    var lowerLetters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'];
    var upperLetters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
    var numbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    var specialCharacters = ['!', '"', '"', '#', '$', '%', '&', '\'', '(', ')', '*', '+', ',', '-', '.', '/', ':', ';', '<', '=', '>', '?', '@', '[', '\\', ']', '^', '_', '`', '{', '|', '}', '~'];
    var outCharacters = lowerLetters;
    if (upperGen) {
        outCharacters = outCharacters.concat(upperLetters);
    }
    if (numbersGen) {
        outCharacters = outCharacters.concat(numbers);
    }
    if (symbolsGen) {
        outCharacters = outCharacters.concat(specialCharacters);
    }
    var passwordArray = [];
    for (var i = 1; i < passwordLength; i++) {
        passwordArray.push(outCharacters[Math.floor(Math.random() * outCharacters.length)]);
    };

    var passwordInput = passwordArray.join("");
    return passwordInput;

};

var changePasswordForm = function (user, url_update, callBack) {
    var msgError = function () {
        Swal.showValidationMessage(JSR.password + " : " + error_saving)
        return false;
    };
    Swal.fire({
        html: '{0}:<br><b>{1}</b>'.format(JSR.password_enter,user.email) +
            '<hr/>' +
            '<input id="swal-input1" type="button" onclick="$(\'#new-pass\').val(window.passwordGenerator())" class="btn btn-outline-warning btn-xs center" value="' + JSR.generate_password+'" />',
        input: 'text',
        inputPlaceholder: JSR.password_new,
        inputAttributes: {
            autocapitalize: 'off',
            id: "new-pass"
        },
        inputValidator: function (value) {
            if (!value || value.length < 8 || value.length > 20)
                return '{0}, {1} ({2})'.format(JSR.required_field, JSR.password, JSR.msg_8_20_characters)
        },
        showCancelButton: true,
        cancelButtonText: JSR.cancel,
        confirmButtonText: 'Changer',
        showLoaderOnConfirm: true,
        allowOutsideClick: true,
        preConfirm:
            function (password) {
                try {
                    //console.log(url_update)
                    return $.post(url_update, { "id": user.id, "email": user.email, "password": password })
                        .done(function (response) {

                            if (response.status != 200)
                                throw JSR.error_occurred;

                            if (callBack)
                                callBack(password);

                            return true;
                        })

                        .fail(function (err) { console.log(err); return msgError(); })
                        .catch(function () { return false })

                } catch (error) {
                    Swal.showValidationMessage(error);
                    return false;
                }
            },
    }).then(function (result) {
        if (result.isConfirmed) {
            toastr.success(JSR.password_new + " : " + JSR.validated)
        }
    });
}

