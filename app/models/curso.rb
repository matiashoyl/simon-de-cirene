class Curso < ActiveRecord::Base
	audited
	
	belongs_to :programa
	has_many :sesions
	has_many :users, :through => :sesions

	attr_accessible :codigo, :nombre, :comuna, :programa_id, :relator_jefe_id

	validates :codigo, :nombre, :comuna, :programa_id, :relator_jefe_id, :presence => true
	validates :codigo, :uniqueness => true

	def alumnos
		alumnos = Array.new
		alumnos_ids = AlumnoCurso.where(:curso_id => self).select(:alumno_id).group(:alumno_id).collect{|p| p.alumno_id}
		alumnos_ids.each do |alumno_id|
	      alumno = Alumno.find(alumno_id)
	      alumnos.push alumno
	    end
	    return alumnos
	end

	def formularios
		formularios = Array.new
		formularios_ids = FormularioCurso.where(:curso_id => self).select(:formulario_id).group(:formulario_id).collect{|p| p.formulario_id}
		formularios_ids.each do |formulario_id|
	      formulario = Formulario.find(formulario_id)
	      formularios.push formulario
	    end
	    return formularios
	end
end
