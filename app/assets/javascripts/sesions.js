function setRut(alumno_id){
    $(alumno_id).Rut({
      on_error: function(){ alert('Rut incorrecto'); }
    });
}

function setTimers(id_inicio, id_termino){
    var hora = new Date();
    var horaInicio = hora.toLocaleTimeString();
    var aux = new Date(hora.setHours(hora.getHours()+2));
	var horaTermino = hora.toLocaleTimeString();
	$(id_inicio).timepicker({defaultTime: horaInicio});
    $(id_termino).timepicker({defaultTime: horaTermino});
    $(id_inicio).timepicker().on('changeTime.timepicker', function(e) {
    	var hour = parseInt($(id_inicio).val().substring(0,2));
    	var minutes = parseInt($(id_inicio).val().substring(3,5));
    	var PMoAM = $(id_inicio).val().substring(6);
    	var date = new Date();
    	date.setHours(hour + 2);
    	date.setMinutes(minutes);
    	date.setSeconds(0);
    	var aux2 = new Date(date);
    	var nuevaHoraTermino = aux2.toLocaleTimeString();
    	nuevaHoraTermino = nuevaHoraTermino.substring(0, nuevaHoraTermino.length-6) + " " + PMoAM;
    	$(id_termino).timepicker('setTime', nuevaHoraTermino);
  	});    
}
function setTimersEdit(id_inicio, id_termino, hora_inicio, hora_termino){
    var horaInicio = hora_inicio;
    var horaTermino = hora_termino;
    $(id_inicio).timepicker({defaultTime: horaInicio});
    $(id_termino).timepicker({defaultTime: horaTermino});
        
}

$(document).ready(function() {
    $("#alumno_profesion").select2({
        width: "resolve",
        placeholder: "Selecciona uno o varios rubros"
    });
    $("#alumno_comuna").select2({
        width: "resolve",
        placeholder: "Comuna"
    });
    $("#alumno_sexo").select2({
        width: "resolve",
        placeholder: "Sexo"
    });
    $("#alumno_quintil").select2({
        width: "resolve",
        placeholder: "Quintil"
    });
    $("#alumno_escolaridad").select2({
        width: "resolve",
        placeholder: "Escolaridad"
    });
});
