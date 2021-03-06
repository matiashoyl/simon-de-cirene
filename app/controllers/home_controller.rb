class HomeController < ApplicationController
    def index
        if user_signed_in?
            if current_user.has_role? :relator
                @cursos = Curso.where(:relator_jefe_id => current_user, :active => true).all
                
                @formularios_sin_contestar = Array.new
                @cursos_formularios_sin_contestar = Array.new
                @alumnos_con_tres_o_mas_inasistencias = Array.new
                @cursos_alumnos_con_tres_o_mas_inasistencias = Array.new
                @cursos.each do |curso|
                    curso.formularios.each do |formulario|
                        if !formulario.contestado?(curso)
                            @formularios_sin_contestar.push formulario
                            @cursos_formularios_sin_contestar.push curso
                        end
                    end
                    curso.alumnos.each do |alumno|
                        if alumno.numero_inasistencias(curso) > 2
                            @alumnos_con_tres_o_mas_inasistencias.push alumno
                            @cursos_alumnos_con_tres_o_mas_inasistencias.push curso
                        end
                    end
                end
            end
        end
    end


    def cambios
      @cambios = Audited::Adapters::ActiveRecord::Audit.last(30)
    end

    def ayuda_formularios

    end

    def resumen_programa
        @programa = Programa.find(params[:id])
        @cursos = @programa.cursos.where(:active => true)

        #@sesiones_a_la_fecha = Sesion.where('fecha < ?', DateTime.now).all
        @sesiones = Array.new
        @cursos.each do |curso|
            curso.sesions.where(:active => true).each do |sesion|
                @sesiones.push sesion
            end
        end

        @sesiones_a_la_fecha = Array.new
        @cursos.each do |curso|
            curso.sesions.where('fecha < ?', DateTime.now).each do |sesion|
                @sesiones_a_la_fecha.push sesion
            end
        end

        @sesiones_pocos_asistentes = Array.new
        @sesiones_sin_asistencia = Array.new
        @alumnos_baja_asistencia = Array.new
        @bajas_asistencias = Array.new
        @curso_alumno_baja_asistencia = Array.new
        @formularios_sin_contestar = Array.new
        @cursos_formularios_sin_contestar = Array.new

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
            curso.formularios.each do |formulario|
                if !formulario.contestado?(curso)
                    @formularios_sin_contestar.push formulario
                    @cursos_formularios_sin_contestar.push curso
                end
            end
        end

        respond_to do |format|
            format.js
        end
    end

    def resumen_curso
        @curso = Curso.find(params[:id])
        @sesiones = @curso.sesions.where(:active => true)
        @sesiones_a_la_fecha = @curso.sesions.where(:active => true).where('fecha < ?', DateTime.now)

        @sesiones_pocos_asistentes = Array.new
        @sesiones_sin_asistencia = Array.new
        @alumnos_baja_asistencia = Array.new
        @bajas_asistencias = Array.new
        @formularios_sin_contestar = Array.new

        @sesiones_a_la_fecha.each do |sesion|
            if sesion.curso.alumnos.empty?
                #do nothing
            elsif sesion.porcentaje_asistentes == "NA"
                @sesiones_sin_asistencia.push sesion
            elsif sesion.porcentaje_asistentes < 85
                @sesiones_pocos_asistentes.push sesion
            end
        end

        @curso.alumnos.each do |alumno|
            if alumno.porcentaje_asistencia(@curso) != "NA"
                if alumno.porcentaje_asistencia(@curso) < 75
                    @alumnos_baja_asistencia.push alumno
                    @bajas_asistencias.push alumno.porcentaje_asistencia(@curso)
                end
            end
        end

        @curso.formularios.each do |formulario|
            if !formulario.contestado?(@curso)
                @formularios_sin_contestar.push formulario
            end
        end

        respond_to do |format|
            format.js
        end
    end

    def calendario
        @index = Array.new
        @sesiones = Array.new
        if current_user.has_role? :relator
            Sesion.where(:user_id => current_user).order(:fecha).each_with_index do |sesion, index|
                @sesiones.push sesion
                @index.push index
            end
        else
            Curso.all_active.each do |curso|
                index = 0
                curso.sesions.order(:fecha).each do |sesion|
                    @sesiones.push sesion
                    @index.push index
                    index = index + 1
                end
            end
        end
    end
end
