class Sesion < ActiveRecord::Base
	audited
	
	belongs_to :curso
	belongs_to :user

 	attr_accessible :comentario, :direccion, :fecha, :hora_inicio, :hora_termino, :tema, :tipo, :curso_id, :user_id

 	validates :tema, :tipo, :direccion, :fecha, :hora_inicio, :hora_termino, :curso_id, :user_id, :presence => true

 	def self.all_active
		sesiones = Array.new
		Curso.all_active.each do |curso|
			sesiones += curso.sesions
		end
		return sesiones
	end

 	def porcentaje_asistentes
 		alumno_sesiones = AlumnoSesion.where(:sesion_id => self).all
 		asistentes_presentes = 0.0
 		asistentes_totales = 0.0
 		alumno_sesiones.each do |alumno_sesion|
 			if alumno_sesion.presente
 				asistentes_presentes = asistentes_presentes + 1
 			end
 			asistentes_totales = asistentes_totales + 1
 		end

 		if asistentes_totales > 0
	 		porcentaje_asistentes = 0
	 		begin
	 			porcentaje_asistentes = ((asistentes_presentes/asistentes_totales).round(2)*100).to_i
	 		rescue
	 			porcentaje_asistentes = 0
	 		end
	 	else
	 		porcentaje_asistentes = "NA"
	 	end

 		return porcentaje_asistentes
 	end

 	def relator
 		relator = User.find(self.user_id)
 		return relator
 	end
end
