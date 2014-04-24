$(document).ready(function(){

    //Manejo de la hora. Parte con la hora actual y la final dos horas más adelante.
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

    //Codigo necesario para redireccionar a la página indicada al completar un formulario
    var url_actual = window.location.pathname;
    var curso = url_actual.split("/")[2];
    var html = ""
    html += '<script type="text/javascript">var submitted=false;</script>';
    html += '<iframe name="hidden_iframe" id="hidden_iframe" style="display:none;" onload="if(submitted) {window.location=';
    html += "'";
    html += window.location.origin + "/sesions/curso/" + curso;
    html += "'";
    html += ';}"></iframe>';
    $("#ss-form").before(html);
    $("#ss-form").attr('target', 'hidden_iframe');
    $("#ss-form").attr('onsubmit', 'submitted=true;');

    //Codigo necesario para los popovers de la vista resumen de cursos
    $('.sesion-popover').popover({ trigger: "hover" });
    
})

function setTimersEdit(id_inicio, id_termino, hora_inicio, hora_termino){
    var horaInicio = hora_inicio;
    var horaTermino = hora_termino;
    $(id_inicio).timepicker({defaultTime: horaInicio});
    $(id_termino).timepicker({defaultTime: horaTermino});    
}