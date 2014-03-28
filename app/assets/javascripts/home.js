$(document).ready(function(){
	$("#loading").hide();
	$("#programas").select2();
	$("#cursos").select2();
	$("#programas").on("select2-selecting", function(e) {
		$("#resumen").html("");
		$( "#loading" ).fadeIn( "fast" );
		$.ajax({
			type: "GET",
			url: "/resumen/programa/" + e.val + ".js",
			complete: hideLoadingImage
		});
		$('#cursos').select2('data', {id: null, text: "Selecciona un curso"})
	})
	$("#cursos").on("select2-selecting", function(e) {
		$("#resumen").html("");
		$( "#loading" ).fadeIn( "fast" );
		$.ajax({
			type: "GET",
			url: "/resumen/curso/" + e.val + ".js",
			complete: hideLoadingImage
		});
		$('#programas').select2('data', {id: null, text: "Selecciona un programa"})
	})

	
})

function hideLoadingImage() {
    $( "#loading" ).hide();
    $('.curso-popover').popover({ trigger: "hover" });
}
