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
	$('#recur_budget_begin_or_end_of_month_1').click(function(){
		$('#budget_transaction_date').attr('disabled','disabled');
	});// disable the text box for date input of the recur_budget/new form if selected	
	$('#recur_budget_begin_or_end_of_month_2').click(function(){
		$('#budget_transaction_date').attr('disabled','disabled');
	});// disable the text box for date input of the recur_budget/new form if selected	
	$('#reset').click(function(){
		$('#budget_transaction_date').removeAttr('disabled');
	});//	
	$(function(){
		$('#spending_transaction_date').datepicker({ dateFormat: 'mm/dd/yy' });
	});//prompts date picker in spending/new form
	$('#advance_search').click(function(){
	//	$('#advance_search_form').attr('display','visible')
	});
});

function show_message(){
	$('#user_password').focus(function(){
		$('#password_description').show();
	});  
	$('#user_password').blur(function(){
		$('#password_description').hide();
	}); 	
}
$(document).ready(show_message);
$(document).on('page:load', show_message);


/*$(document).ready(function(){
	alert("it's ready");
});
$(window).bind('beforeunload', function(event) {    

    return false;
});*/
