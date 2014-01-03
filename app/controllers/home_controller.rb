class HomeController < ApplicationController
  def index
    #@sesiones_a_la_fecha = Sesion.where('fecha < ?', DateTime.now).all
    @sesiones_a_la_fecha = Sesion.all
    @cursos = Curso.all
    @alumnos = Alumno.all

    @sesiones_pocos_asistentes = Array.new
    @sesiones_sin_asistencia = Array.new
    @alumnos_baja_asistencia = Array.new
    @bajas_asistencias = Array.new
    @curso_alumno_baja_asistencia = Array.new

    @sesiones_a_la_fecha.each do |sesion|
    	if sesion.curso.alumnos.empty?
    		#do nothing
    	elsif sesion.porcentaje_asistentes == "NA"
    		@sesiones_sin_asistencia.push sesion
    	elsif sesion.porcentaje_asistentes < 85
    		@sesiones_pocos_asistentes.push sesion
    	end
    end

    @cursos.each do |curso|
    	curso.alumnos.each do |alumno|
            if alumno.porcentaje_asistencia(curso) != "NA"
        		if alumno.porcentaje_asistencia(curso) < 75
        			@alumnos_baja_asistencia.push alumno
        			@bajas_asistencias.push alumno.porcentaje_asistencia(curso)
        			@curso_alumno_baja_asistencia.push curso
        		end
            end
    	end
    end

  end
end
