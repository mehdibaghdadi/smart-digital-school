$(function () {
    //func validate
    var validateInput = function (self, title) {
        var checkForm = function () {
            try {
                var validity = self.validity;
                var isValid = (validity.typeMismatch == false)
                    && (validity.valueMissing == false)
                    && (validity.patternMismatch == false)
                    && (validity.rangeUnderflow == false)
                    ;

                console.log(title)
                if (!self.value)
                    isValid = false;

                //self.setCustomValidity(isValid ? '' : title);
                $(self).addClass(!isValid ? "is-invalid" : "is-valid")
                $(self).removeClass(isValid ? "is-invalid" : "is-valid")
            } catch (e) { console.log(e) }
        }
        checkForm();
        self.addEventListener("keyup", function () { checkForm(); });
        self.addEventListener("change", function () { checkForm(); });
        
    }

    //pattern
    $(":password").attr('pattern', JSR.password_pattern);
    $("[data-type='password']").attr('pattern', JSR.password_pattern);

    //required
    $("form,input,textarea,select").filter('[required]').attr('autocomplete', 'new-password');

    $('input,textarea,select').filter('[required]').bind("invalid", function (event) {
        var message = JSR.required_field;
        var title = this.title ? this.title : null;
        var data_type = $(this).attr("data-type");
        var type = data_type ? data_type : this.type;

        try {
            switch (type) {
                case "email": message = JSR.email;
                    break;
                case "password": message = JSR.password + ": " + JSR.msg_8_20_characters;
                    break;
                case "text": message = JSR.text; ;
                    break;
                case "tel":
                    var ln = $(this).attr('placeholder')?.match(/\d/g)?.length || '_';
                    message = JSR.phone + " = " + ln + " " + JSR.characters;
                    break;
                default: message = JSR.type1+" {0}".format(this.type);
            }
            message = title ? title : message;
        } catch (e) {
            console.log(e)
        }
        message = "{0} : {1}".format(JSR.required_field, message)
        validateInput(this, message);
    });

           
    // masks
    $('input,textarea,select').filter('[data-mask]:visible').inputmask();
});
