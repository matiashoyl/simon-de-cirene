$(document).ready(function() {

	var date = new Date();
	var d = date.getDate();
	var m = date.getMonth();
	var y = date.getFullYear();
	
	$('#calendar').fullCalendar({
		monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
		firstDay: 1,
		monthNamesShort: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
		dayNames: ['Domingo', 'Lunes', 'Martes', 'Miercoles',
		'Jueves', 'Viernes', 'Sábado'],
		dayNamesShort: ['Dom', 'Lun', 'Mar', 'Mie', 'Jue', 'Vie', 'Sab'],
		buttonText:
		{
			prev:     ' ◄ ',
			next:     ' ► ',
			prevYear: ' &lt;&lt; ',
			nextYear: ' &gt;&gt; ',
			today:    'Hoy',
			month:    'Mes',
			week:     'Semana',
			day:      'Día'
		},
		header: {
			left: 'prev,next today',
			center: 'title',
			right: 'month,agendaWeek,agendaDay'
		},
		editable: true,
		
	});
});

function agregarEvento(nombre, direccion, fecha, hora_inicio, hora_termino){
		var date = new Date(fecha);
		var year = date.getFullYear();
		var month = date.getMonth();
		var day = date.getDate();
		var hora_inicio = new Date(hora_inicio.substring(0,hora_inicio.length - 4));
		var horas_inicio = hora_inicio.getHours();
		var minutos_inicio = hora_inicio.getMinutes();
		var hora_termino = new Date(hora_termino.substring(0,hora_termino.length - 4));
		var horas_termino = hora_termino.getHours();
		var minutos_termino = hora_termino.getMinutes();

		var start = new Date(year, month, day + 1, horas_inicio, minutos_inicio, 0);
		var end = new Date(year, month, day + 1, horas_termino, minutos_termino, 0);


	$(document).ready(function() {
		events = {
			title: nombre + " - " + direccion,
			start: start,
			end: end,
			allDay: false
		};
		evento = {
			title: 'All didid Event',
			start: new Date(2014, 2, 1)
		};
		$('#calendar').fullCalendar('renderEvent', events , true );
	});
};
