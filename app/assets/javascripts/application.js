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
//= require jquery-ui/effect-blind
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .
//= require_tree ../../../vendor/assets/javascripts/.

$(document).on('page:load',ready);
$(document).ready(ready);
function ready() {
	$('#recur_budget_begin_or_end_of_month_1').click(function(){
		$('#budget_transaction_date').attr('disabled','disabled');
	});// disable the text box for date input of the recur_budget/new form if selected	
	$('#recur_budget_begin_or_end_of_month_2').click(function(){
		$('#budget_transaction_date').attr('disabled','disabled');
	});// disable the text box for date input of the recur_budget/new form if selected	
	$('#reset').click(function(){
		$('#budget_transaction_date').removeAttr('disabled');
	});//	
	
	$('#spending_transaction_date').datepicker({ dateFormat: 'mm/dd/yy' });//prompts date picker in spending/new form
	$('#advance_search_start_date_string').datepicker({ dateFormat: 'mm/dd/yy' });//prompts date picker in spending/_search_form
	$('#advance_search_end_date_string').datepicker({ dateFormat: 'mm/dd/yy' });//prompts date picker in spending/_search_form
 // enable tabbable tabs
	$('#myTab a').click(function (e) {
		  e.preventDefault();
		  $(this).tab('show');
		  var form_activated='#'+$(this).attr('href').slice(1);
		  if(form_activated=='#search_form'){
			$('#search_form').show();
		  	$('#advance_search_form').hide();
		  }
		  else if (form_activated=='#advance_search_form'){
			$('#search_form').hide();
		  	$('#advance_search_form').show();
		  }
	});
	$('#chart_tab a').click(function (e) {
		  e.preventDefault();
		  $(this).tab('show');
		  var form_activated='#'+$(this).attr('href').slice(1);
		  toggle_chart_menu(form_activated);
	});
	
}
function toggle_chart_menu(id){
	$('#available_budget').hide();
	$('#monthly_spending').hide();
	$('#spending_breakdown').hide();
	$('#search_form_pie').hide();
	$(id).show();
	if (id=='#spending_breakdown'){
		$('#search_form_pie').show();
	}
}

/*function search_form(event){
	$('#advance_search_form').hide();
	$('#search_form').show();
	alert(event.target.parent().nodeName);
	event.target.parent().attr('class','active');
	alert("searchform");
}
function advance_search_form(event){
	$('#advance_search_form').show();
	$('#search_form').hide();
	alert(event.target.parent().nodeName);
	event.target.parent().attr('class','active');
	alert("advance search form");
}*/
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
