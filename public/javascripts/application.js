// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {

    // make save-me-button behave a little more sane
    $('#save-me-button').click(function() {
        if( $('#more_information').css("display") == "none" ){
            $('#more_information').grow();
            return false;
        }
        else{
            $('#location').shrink();
            //$('#more_information').hide();
            return true;
        }
    });

// listen for enter key and behave according to form view status
//
//   $(document).keyup( function(e) {
//        if(e.keyCode == 13) {
//            if ( $('#more_information').css("display") == "none"){
//            }
//            $('form').submit();
//        }
//
//   });
});

