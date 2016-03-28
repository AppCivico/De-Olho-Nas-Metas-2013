//Based entirely on facebook developers documentation

window.fbAsyncInit = function() {
    FB.init({
        appId      : '700976226602138',
        status     : true,
        cookie     : true,
        xfbml      : true
    });

    FB.Event.subscribe('auth.authResponseChange', function(response) {
        if (response.status === 'connected') {
            connectAPI(response);
        } else if (response.status === 'not_authorized') {
            FB.login();
        } else {
            FB.login();
        }
    });
};

// Load the SDK asynchronously
(function(d){
    var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
    if (d.getElementById(id)) {return;}
    js = d.createElement('script'); js.id = id; js.async = true;
    js.src = "//connect.facebook.net/pt_BR/all.js";
    ref.parentNode.insertBefore(js, ref);
}(document));

function connectAPI(auth_resp) {

    processAuth(auth_resp);

    FB.api('/me', function(response) {

        complete_pre_registration(response);

        console.log(response);
    });

}

function complete_pre_registration (response) {
    if(!response) {
        return false;
    }
    console.log(response);
    if(response.name) {
        $('#elm_name').val(response.name);
    }

    if(response.gender) {
        if(response.gender == 'male') {
            $('#elm_gender').val('m');
        } else {
            $('#elm_gender').val('f');
        }
    }

    if(response.birthday) {
        var $b_day = response.birthday.split('/');
        $('#elm_birth_date').val($b_day[1]+'/'+$b_day[0]+'/'+$b_day[2]);
    }

    if(response.email) {
        $('#elm_email').val(response.email);
    }

    if(response.relationship_status) {
        if(response.relationship_status == 'Single') {
            $('#elm_marital_state').val('S');
        }
        if(response.relationship_status == 'Maried') {
            $('#elm_marital_state').val('C');
        }
        if(response.relationship_status == 'Divorced') {
            $('#elm_marital_state').val('D');
        }
        if(response.relationship_status == 'Widower') {
            $('#elm_marital_state').val('V');
        }
    }

}

function processAuth(auth_resp) {
    if(!auth_resp) {
        return false;
    }

    $.ajax({
        url: '/form/fb-auth',
        dataType: 'json',
        data: { signed_request: auth_resp.authResponse.signedRequest },
        success: function (result) {
            $('#pre_reg').append(
                '<input type="hidden" value='+result[0].code+' name="fb_code">'+
                '<input type="hidden" value='+result[0].user_id+' name="fb_id">'+
                '<input type="hidden" value='+result[0].issued_at+' name="fb_timestamp">'
            );
        },
        error: function (err) {
            console.log(err);
        }
    });
}