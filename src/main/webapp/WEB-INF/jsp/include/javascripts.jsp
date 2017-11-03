<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%--<script type="text/javascript" src="${pluginJs}/jquery-1.8.2.js"></script>--%>
<script type="text/javascript" src="${pluginJs}/jquery.js"></script>
<script type="text/javascript" src="${pluginJs}/TweenMax.min.js"></script>
<script type="text/javascript" src="${pluginJs}/jquery-placeholder.min.js"></script>
<script type="text/javascript" src="${pluginJs}/jquery-ui.js"></script>
<script type="text/javascript" src="${pluginJs}/moment.min.js"></script>
<script type="text/javascript" src="${pluginJs}/jquery.daterangepicker.min.js"></script>
<script type="text/javascript" src="${pluginJs}/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="${pluginJs}/tooltipsy.min.js"></script>

<script type="text/javascript" src="${Js}/ui.js"></script>
<script type="text/javascript" src="${Js}/util.js"></script>
<script type="text/javascript" src="${Js}/popup.js"></script>

<script src="https://apis.google.com/js/platform.js" async defer></script>

<script type="text/javascript">
	$(document).ready(function () {
		$(window).scrollTop(0);
	});

	function region(regionName) {
        _oRequest = $.ajax({
            url : "/region/" + regionName,
            cache : false,
            async: true,
            data : "",
            type : "GET",
            error : function() {
                _oRequest = null;
            },
            complete : function(oRes) {
                $("#container").empty();
                $("#container").html(oRes.responseText);
            }
        });
    }

    function detail(hotelNo) {
        _oRequest = $.ajax({
            url : "/detail",
            cache : false,
            async: true,
            data : {"hotelNo" : hotelNo},
            type : "POST",
            error : function() {
                _oRequest = null;
            },
            complete : function(oRes) {
                $("#container").empty();
                $("#container").html(oRes.responseText);
			}
        });
    }

    function shop(typeNo) {
        _oRequest = $.ajax({
            url : "/shop/booking",
            cache : false,
            async: true,
            data : {"typeNo" : typeNo},
            type : "GET",
            error : function() {
                _oRequest = null;
            },
            complete : function(oRes) {
                $("#container").empty();
                $("#container").html(oRes.responseText);
			}
        });
    }





    var access_token;
    var user_id;
    var user_email;
    var user_name;

    // This is called with the results from from FB.getLoginStatus().
    function statusChangeCallback(response) {
        console.log('statusChangeCallback');
        console.log(response);
        // The response object is returned with a status field that lets the
        // app know the current login status of the person.
        // Full docs on the response object can be found in the documentation
        // for FB.getLoginStatus().
        if (response.status === 'connected') {
            // Logged into your app and Facebook.
            //testAPI();
            access_token = response.authResponse.accessToken; //get access token
            user_id = response.authResponse.userID; //get FB UID

            FB.api('/me', function(response) {
                user_email = response.email; //get user email
                user_name = response.name; //get user name
                console.log('access_token : ' + access_token + '\nuser_id : ' + user_id + '\nuser_email : ' + user_email + '\nuser_name : ' + user_name);
                //document.getElementById('status').innerHTML = 'Thanks for logging in, ' + user_name + '!';

                $('#link-join').hide();
                $('#link-login').hide();
                $('#login-info').html('<b>' + user_name + '</b> 님');
                $('#login-info').show();
            });
        } else if (response.status === 'not_authorized') {
            // The person is logged into Facebook, but not your app.
            $('#login-info').html('Please log into this app. status : not_authorized');

            $('#link-join').show();
            $('#link-login').show();
        } else {
            // The person is not logged into Facebook, so we're not sure if
            // they are logged into this app or not.
            $('#login-info').html('Please log into Facebook. status : ' + response.status);

            $('#link-join').show();
            $('#link-login').show();
        }
    }

    // This function is called when someone finishes with the Login
    // Button.  See the onlogin handler attached to it in the sample
    // code below.
    function checkLoginState() {
        FB.getLoginStatus(function(response) {
            statusChangeCallback(response);
        });
    }

     // Load the SDK asynchronously
     (function(d, s, id) {
     var js, fjs = d.getElementsByTagName(s)[0];
     if (d.getElementById(id)) return;
     js = d.createElement(s); js.id = id;
     //js.src = "//connect.facebook.net/en_US/sdk.js";
     js.src = "//connect.facebook.net/en_US/sdk/debug.js";
     fjs.parentNode.insertBefore(js, fjs);
     }(document, 'script', 'facebook-jssdk'));

     // Here we run a very simple test of the Graph API after login is
     // successful.  See statusChangeCallback() for when this call is made.
     function testAPI() {
     console.log('Welcome!  Fetching your information.... ');
     FB.api('/me', function(response) {
     console.log('Successful login for: ' + response.name);
     document.getElementById('status').innerHTML =
     'Thanks for logging in, ' + response.name + '!';
     });
     }

    window.fbAsyncInit = function() {
        FB.init({
            appId      : '1766854950301704',
            cookie     : true,  // enable cookies to allow the server to access the session
            status     : true, // check login status
            xfbml      : true,  // parse social plugins on this page
            version    : 'v2.8' // use graph api version 2.8
        });
        //FB.AppEvents.logPageView();

        // Now that we've initialized the JavaScript SDK, we call
        // FB.getLoginStatus().  This function gets the state of the
        // person visiting this page and can return one of three states to
        // the callback you provide.  They can be:
        //
        // 1. Logged into your app ('connected')
        // 2. Logged into Facebook, but not your app ('not_authorized')
        // 3. Not logged into Facebook and can't tell if they are logged into
        //    your app or not.
        //
        // These three cases are handled in the callback function.

        FB.getLoginStatus(function(response) {
            statusChangeCallback(response);
        });

    };

    function fb_join(){
        FB.login(function(response) {

            if (response.authResponse) {
                console.log('Welcome!  Fetching your information.... ');
                //console.log(response); // dump complete info
                access_token = response.authResponse.accessToken; //get access token
                user_id = response.authResponse.userID; //get FB UID

                FB.api('/me', function(response) {
                    user_email = response.email; //get user email
                    user_name = response.name; //get user name
                    // you can store this data into your database
                    console.log('access_token : ' + access_token + '\nuser_id : ' + user_id + '\nuser_email : ' + user_email + '\nuser_name : ' + user_name);

                    popup.layerPopClose($('#pop-join'));
                    $('#link-join').disable();  //.addClass('disabled');
                    $('#link-login').disable();
                    $('#lable-userinfo').val(user_name);
                    $('#lable-userinfo').enable();
                });
            } else {
                //user hit cancel button
                console.log('User cancelled login or did not fully authorize.');
            }
        }, {
            scope: 'public_profile,email'
        });
    }

    function fb_login(){
        FB.login(function(response) {

            if (response.authResponse) {
                console.log('Welcome!  Fetching your information.... ');
                //console.log(response); // dump complete info
                access_token = response.authResponse.accessToken; //get access token
                user_id = response.authResponse.userID; //get FB UID

                FB.api('/me', function(response) {
                    user_email = response.email; //get user email
                    user_name = response.name; //get user name
                    // you can store this data into your database
                    console.log('access_token : ' + access_token + '\nuser_id : ' + user_id + '\nuser_email : ' + user_email + '\nuser_name : ' + user_name);

                    popup.layerPopClose($('#pop-login'));
                    $('#link-join').disable();  //.addClass('disabled');
                    $('#link-login').disable();
                    $('#lable-userinfo').val(user_name);
                    $('#lable-userinfo').enable();
                });
            } else {
                //user hit cancel button
                console.log('User cancelled login or did not fully authorize.');
            }
        }, {
            scope: 'public_profile,email'
        });
    }

    (function() {
        var e = document.createElement('script');
        e.src = document.location.protocol + '//connect.facebook.net/en_US/all.js';
        e.async = true;
        //document.getElementById('fb-root').appendChild(e);
    }());


    // GOOGLE LOGIN
    function onSignIn(googleUser) {
        // Useful data for your client-side scripts:
        var profile = googleUser.getBasicProfile();
        console.log("ID: " + profile.getId()); // Don't send this directly to your server!
        console.log('Full Name: ' + profile.getName());
        console.log('Given Name: ' + profile.getGivenName());
        console.log('Family Name: ' + profile.getFamilyName());
        console.log("Image URL: " + profile.getImageUrl());
        console.log("Email: " + profile.getEmail());

        // The ID token you need to pass to your backend:
        var id_token = googleUser.getAuthResponse().id_token;
        console.log("ID Token: " + id_token);
    };
</script>