class Programa < ActiveRecord::Base
	audited
	
	has_many :cursos
	has_many :sesions, :through => :cursos

  	attr_accessible :nombre, :tipo, :active

  	validates :nombre, :tipo, :presence => true
  	validates :tipo, :inclusion => {:in => ["Social", "Microempresas"]}

    def self.all_active
      return Programa.where(:active => true).all
    end

  	def alumnos
  		alumnos = Array.new
  		self.cursos.each do |curso|
  			alumnos_curso = curso.alumnos
  			alumnos_curso.each do |alumno|
  				unless !alumnos_curso.include?(alumno)
  					alumnos.push alumno
  				end
  			end
  		end
  		return alumnos
  	end

  	def sesiones
  		sesiones = Array.new
  		self.cursos.each do |curso|
  			sesiones_curso = curso.sesions
  			sesiones_curso.each do |sesion|
  				unless !sesiones_curso.include?(sesion)
  					sesiones.push sesion
  				end
  			end
  		end
  		return sesiones
  	end

  	def formularios
  		formularios = Array.new
  		self.cursos.each do |curso|
  			formularios_curso = curso.formularios
  			formularios_curso.each do |formulario|
  				unless !formularios_curso.include?(formulario)
  					formularios.push formulario
  				end
  			end
  		end
  		return formularios
  	end

    def asistencia_promedio
      suma = 0
      num_cursos = 0
      self.cursos.each do |curso|
        unless curso.asistencia == "NA"
          suma += curso.asistencia
          num_cursos += 1
        end
      end
      if num_cursos != 0 
        return ((suma/num_cursos).round(2)).to_i
      else
        return "NA"
      end
    end

    def asistencia_sobre_el_total_promedio
      suma = 0
      num_cursos = 0
      self.cursos.each do |curso|
        unless curso.asistencia_sobre_el_total == "NA"
          suma += curso.asistencia_sobre_el_total
          num_cursos += 1
        end
      end
      if num_cursos != 0 
        return ((suma/num_cursos).round(2)).to_i
      else
        return "NA"
      end
    end
end
