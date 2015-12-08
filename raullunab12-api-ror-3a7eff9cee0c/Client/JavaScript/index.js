var url="http://ec2-52-24-67-120.us-west-2.compute.amazonaws.com:3000/"
var validate = new RegExp(/^[A-Za-z\d _=&]+$/);
var intRegex = new RegExp(/^[\d =&]*$/);
    function chargeButtons() {
        function validateValues(val)
        {
            if (!val.match(validate)) {
                
                console.log('asd');
                return false;
            }
            return true;
        }
        function validateNumbers(val)
        {
            if (!val.match(intRegex)) {
                return false;
                console.log('asd');
            }
            return true;
        }
        $("#user_login").bind("click", function () {
            var formdata = $("#form_login").serialize();
            var tempurl = url;

            tempurl += "user/authenticate.json";
            console.log(tempurl);
            if (validateValues(formdata)){
            $.ajax({
                url: tempurl,
                method: "POST",
                data: formdata,
                dataType: "json",
                success: function (data) {
                    $('#userlogin_result').val(JSON.stringify(data))
                    localStorage.setItem('authtoken',data.auth_token);
                },
                error:function( jqXHR, textStatus ) {
                    $('#userlogin_result').val(jqXHR.status+" Something went wrong");
                    console.log(textStatus);
                }
            });
        }else{
             $('#userlogin_result').val("Verify the values.");
        }
        });

        $("#user_logout").bind("click", function () {
            var tempurl = url;
            tempurl += "user/logout.json";
            console.log(tempurl);
            $.ajax({
                url: tempurl,
                method: "GET",
                dataType: "json",
                headers: { 'authtoken': localStorage.getItem('authtoken')},
                success: function (data) {
                    $('#userlogin_result').val(JSON.stringify(data))
                },
                error:function( jqXHR, textStatus ) {
                    $('#userlogin_result').val(jqXHR.status+" Something went wrong");
                    console.log(textStatus);
                }
            });
        });

        $("#get_products").bind("click", function () {
            var id = document.getElementById('formproductid').value
            console.log("you press" + id);
            console.log();
            var tempurl = url;
            if (id == "") {
                tempurl += "product.json";
            }
            else {
                tempurl += "product/" + id + ".json";
            }
            if(validateNumbers(id)){
            $.ajax({
                url: tempurl,
                method: "GET",
                headers: { 'authtoken': localStorage.getItem('authtoken')},
                success: function (data) {
                    var requestdata = JSON.stringify(data);
                    $('#products_result').val(requestdata);
                    requestdata = JSON.parse(requestdata);
                    if (requestdata.length == undefined) {
                        $('#edit_product_name').val(requestdata.name);
                        $('#edit_product_price').val(requestdata.price);
                        $('#edit_product_state').val(requestdata.state);
                    }

                },
                error:function( jqXHR, textStatus ) {
                    $('#products_result').val(jqXHR.status+" The code you input doesnt exist or Something went wrong");
                    console.log(textStatus);
                }
            });
        }else{
            $('#products_result').val("Verify the values.");
        }
        });
        $("#new_product").bind("click", function () {
            var formdata = $("#form_newproduct").serialize();
            var tempurl = url;
            tempurl += "product.json";
            if(validateValues(formdata)){
            $.ajax({
                url: tempurl,
                method: "POST",
                data: formdata,
                dataType: "json",
                headers: { 'authtoken': localStorage.getItem('authtoken')},
                success: function (data) {
                    $('#createproduct_result').val(JSON.stringify(data))
                },
                error:function( jqXHR, textStatus ) {
                    $('#createproduct_result').val(jqXHR.status+" Something went wrong");
                    console.log(textStatus);
                }
            });
        }else{
              $('#createproduct_result').val("Verify the values.");
        }
        });

        $("#edit_product").bind("click", function () {
            var formdata = $("#form_editproduct").serialize();
            var tempurl = url;
            tempurl += "product.json";
            if(validateValues(formdata)){
            $.ajax({
                url: tempurl,
                method: "PUT",
                data: formdata,
                dataType: "json",
                headers: { 'authtoken': localStorage.getItem('authtoken')},
                success: function (data) {
                    $('#editproduct_result').val(JSON.stringify(data));
                }
            });
        }else{
            $('#editproduct_result').val("Verify the values.");
        }
        });
        $("#get_transactions").bind("click", function () {
            console.log();
            var tempurl = url;
            tempurl += "transaction.json";
            $.ajax({
                url: tempurl,
                method: "GET",
                headers: { 'authtoken': localStorage.getItem('authtoken')},
                success: function (data) {
                    var requestdata = JSON.stringify(data);
                    $('#transactions_result').val(requestdata);
                },
                error:function( jqXHR, textStatus ) {
                    $('#transactions_result').val(jqXHR.status+" The code you input doesnt exist or Something went wrong");
                    console.log(textStatus);
                }
            });
        });

        $("#new_transaction").bind("click", function () {
            var formdata = $("#form_newtransaction").serialize();
            var tempurl = url;
            tempurl += "transaction.json";
            if(validateValues(formdata)){
            $.ajax({
                url: tempurl,
                method: "POST",
                data: formdata,
                dataType: "json",
                headers: { 'authtoken': localStorage.getItem('authtoken')},
                success: function (data) {
                    $('#createtransaction_result').val(JSON.stringify(data))
                },
                error:function( jqXHR, textStatus ) {
                    $('#createtransaction_result').val(jqXHR.status+" Something went wrong");
                    console.log(textStatus);
                }
            });
        }else{
            $('#createtransaction_result').val("Verify the values.");
        }
        });
}