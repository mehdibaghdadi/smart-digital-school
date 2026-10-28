/*
###############################
##          Author           ##
##      Beren İlkim Ceylan   ##
## bceylanues[at]gmail[d]com ##
##      @berenceylan         ##
###############################
*/

(function ($) {
    // Collects mails as an array
    var result = [];
    var deleteMailCallBack = null;
    // First input
    var input;
    // Collect mails as CSV in a form invisibly.
    var hiddeninput;
    // Default settings
    var defaults;

    $.fn.multiMailInput = function (options) {
        var $this = this;

        defaults = {
            // Images directory
            imageDir: "image/",
            // Error language settings
            validation_error: "is not valid!",
            duplicate_error: "is already exist!",
            placeholder: "{0} : {1} ...".format(JSR.search, JSR.contacts)
        };

        //Initializing options
        if (typeof options !== "undefined") {
            if (typeof options.imageDir !== "undefined") {
                defaults.imageDir = options.imageDir;
            }
            if (typeof options.validation_error !== "undefined") {
                defaults.validation_error = options.validation_error;
            }
            if (typeof options.duplicate_error !== "undefined") {
                defaults.duplicate_error = options.duplicate_error;
            }
            if (typeof options.placeholder !== "undefined") {
                defaults.placeholder = options.placeholder;
            }
        }

        $this.addMail = function (mail, label, elem) {
            var condition = validateMail(mail, result)["condition"];
            var msg = validateMail(mail, result)["msg"];
            if (condition) {
                elem.siblings(".mmBoxes").prepend("<small class='mmBox animate-opacity' style=''>" + label + "(" + mail + ") <i data-email='" + mail + "' class='deleteBox fa fa-close ml-3' style='cursor: pointer; float: right;'></i></small>");
                result.push(mail);
                input.val("");
                hiddeninput.val($this.getMailsCSV());
                $(".deleteBox").click(function (event) {
                    event.preventDefault();
                    event.stopImmediatePropagation();
                    deleteMMBox(this);
                });
            } else {
                input.val("");
            }

        };

        $this.addMailsArray = function (mailArray, elem) {
            for (var i in mailArray) {
                $this.addMail(mailArray[i], '', elem);
            }
        };
        $this.addMailsCsv = function (mailString, delimeter, elem) {
            var mailArray = mailString.split(delimeter);
            for (var i in mailArray) {
                $this.addMail(mailArray[i], '', elem);
            }
        };
        $this.getMailsCSV = function () {
            var CSV = "";
            for (var i in result) {
                CSV += result[i];
                //If it is not the last item add comma
                if (i != result.length - 1) {
                    CSV += ",";
                }
            }
            return CSV;
        };

        // Constructor    
        this.filter(".multiMail").each(function () {
            input = $(this);
            hiddeninput = input.siblings(".multiMailResult");
            hiddeninput.css("display", "none");
            input.css("position", "relative");
            input.css("margin-top", "0px");
            input.css("margin-left", "0px");
            input.parent(".mmOuter").css("margin-top", "0px");
            input.attr("placeholder", defaults.placeholder);
        });


        return {
            getMails: function () {
                return result;
            },
            addMail: function (mail, label) {
                $this.addMail(mail, label, input);
            },
            addMailArray: function (array) {
                $this.addMailsArray(array, input);
            },
            addMailCSV: function (mailString, delimeter) {
                $this.addMailsCsv(mailString, delimeter, input);
            },
            getMailsCSV: function () {
                return getMailsCSV();
            },
            deleteMail: function (mail) {
                var elem = $('.deleteBox[data-email="' + mail + '"]');
                if (elem)
                    return deleteMMBox(elem);
                else
                    return result;
            },
            deleteAllMails: function (mail) {
                return deleteAllMMBox();
            },
            deleteMailCallBack: function (callBack) {
                deleteMailCallBack = callBack;
            },
            disableRemove: function () {
                $('.deleteBox').addClass('d-none');
            },
            enableRemove: function () {
                $('.deleteBox').removeClass('d-none');
            },
            enableMail: function (mail, enable) {
                var elem = $('.deleteBox[data-email="' + mail + '"]');
                if (elem) {
                    if (enable)
                        $(elem).removeClass('d-none');
                    else
                        $(elem).addClass('d-none');
                }
            }
        };
    };

    function validateMail(mail, array) {
        // returns boolean after validating array of emails
        var msg = "";
        //Regex to test emails
        var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        condition = true;
        if (!re.test(mail)) {
            condition = false;
            msg = "\"" + mail + "\" is not valid!";
        }
        if (array.indexOf(mail) !== -1) {
            condition = false;
            msg += "\"" + mail + "\" is already exist!";
        }
        return {
            "condition": condition,
            "msg": msg
        };
    }

    function deleteMMBox(elem) {
        var itemToDel = $(elem).attr('data-email');
        while (result.indexOf(itemToDel) !== -1) {
            result.splice(result.indexOf(itemToDel), 1);
        }
        $(elem).parent(".mmBox").remove();

        if (deleteMailCallBack)
            deleteMailCallBack(result);

        return result;
    }

    function deleteAllMMBox() {
        $(".mmBox").remove();
        result = [];
        if (deleteMailCallBack)
            deleteMailCallBack(result);

        return result;

    }



}(jQuery));
