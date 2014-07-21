// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.ui.effect-blind
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .
//= require_tree ../../../vendor/assets/javascripts/.

$(document).ready(function() {
	$('#budget_begin_or_end_of_month_1').click(function(){
		$('#budget_transaction_date').attr('disabled','disabled');
	})
	$('#budget_begin_or_end_of_month_2').click(function(){
		$('#budget_transaction_date').attr('disabled','disabled');
	})	
	$('#reset').click(function(){
		$('#budget_transaction_date').removeAttr('disabled');
	})	
	$(function(){
		$('input.transaction_date').initialized=true;
		$('input.transaction_date').datepicker({ dateFormat: 'mm/dd/yy' });
	});
});
$(document).ready(function()
		{
		  $('#user_password').focus(
		    function(){
		    	$('#password_description').show("test");
		    });  
		  $('#user_password').blur(
			function(){
				$('#password_description').hide();
			}); 
		});
/*$(document).ready(function(){
	alert("it's ready");
});
$(window).bind('beforeunload', function(event) {    

    return false;
});*/
