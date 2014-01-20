class Programa < ActiveRecord::Base
	audited
	
	has_many :cursos
	has_many :sesions, :through => :cursos

  	attr_accessible :nombre, :tipo

  	validates :nombre, :tipo, :presence => true
  	validates :tipo, :inclusion => {:in => ["Social", "Microempresas"]}

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
end
