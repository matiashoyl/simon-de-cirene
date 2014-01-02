class Curso < ActiveRecord::Base
	belongs_to :programa
	has_many :sesions
	has_many :users, :through => :sesions

	attr_accessible :codigo, :nombre, :comuna, :programa_id

	validates :codigo, :nombre, :comuna, :programa_id, :presence => true
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
end
