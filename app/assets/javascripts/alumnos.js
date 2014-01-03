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

function setRut(alumno_id){
    $(alumno_id).Rut({
      on_error: function(){ alert('Rut incorrecto'); }
    });
}