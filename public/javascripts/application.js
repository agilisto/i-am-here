// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {
    $('#save-me-button').click(function() {
        if( $('#more_information').css("display") == "none" ){
            $('#more_information').grow();
            return false;
        }
        else{
            return true;
        }
    });
});