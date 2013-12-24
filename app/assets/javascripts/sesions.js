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