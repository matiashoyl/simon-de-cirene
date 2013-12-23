$(document).ready(function(){
    $('[data-behaviour~=datepicker]').datepicker({
	    format: "dd/mm/yyyy",
        language: "es",
	    autoclose: true
	});

    var hora = new Date();
    var horaInicio = hora.toLocaleTimeString();
    var aux = new Date(hora.setHours(hora.getHours()+2));
	var horaTermino = hora.toLocaleTimeString();
	$('#sesion_hora_inicio').timepicker({defaultTime: horaInicio});
    $('#sesion_hora_termino').timepicker({defaultTime: horaTermino});
    $('#sesion_hora_inicio_edit').timepicker({defaultTime: horaInicio});
    $('#sesion_hora_termino_edit').timepicker({defaultTime: horaTermino});
    $('#sesion_hora_inicio').timepicker().on('changeTime.timepicker', function(e) {
    	var hour = parseInt($('#sesion_hora_inicio').val().substring(0,2));
    	var minutes = parseInt($('#sesion_hora_inicio').val().substring(3,5));
    	var PMoAM = $('#sesion_hora_inicio').val().substring(6);
    	var date = new Date();
    	date.setHours(hour + 2);
    	date.setMinutes(minutes);
    	date.setSeconds(0);
    	var aux2 = new Date(date);
    	var nuevaHoraTermino = aux2.toLocaleTimeString();
    	nuevaHoraTermino = nuevaHoraTermino.substring(0, nuevaHoraTermino.length-6) + " " + PMoAM;
    	$('#sesion_hora_termino').timepicker('setTime', nuevaHoraTermino);
  	});
})