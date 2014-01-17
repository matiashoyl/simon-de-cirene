$(document).ready(function(){
	$("#programas").select2();
	$("#cursos").select2();
	$("#programas").on("select2-selecting", function(e) {
		$.ajax({
			type: "GET",
			url: "/resumen/programa/" + e.val + ".js"
		});
		$('#cursos').select2('data', {id: null, text: "Selecciona un curso"})
	})
	$("#cursos").on("select2-selecting", function(e) {
		$.ajax({
			type: "GET",
			url: "/resumen/curso/" + e.val + ".js"
		});
		$('#programas').select2('data', {id: null, text: "Selecciona un programa"})
	})
})