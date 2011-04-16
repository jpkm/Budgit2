// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

	$(document).ready(function() {
		$('p#d').hide();
		$('a#link').click(function(){
			$('#d').show(2000);
		});
		$("select#debit_debit_category").change(function() {
			var value = "";
			$("select#debit_debit_category option:selected").each(function(){
				value += $(this).text() + " ";
				});
			$("#other").text(value);
		});
	});
