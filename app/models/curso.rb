class Curso < ActiveRecord::Base
	audited
	
	belongs_to :programa
	has_many :sesions
	has_many :users, :through => :sesions

	attr_accessible :codigo, :nombre, :comuna, :programa_id, :relator_jefe_id, :active

	validates :codigo, :nombre, :comuna, :programa_id, :relator_jefe_id, :presence => true
	validates :codigo, :uniqueness => true

	def self.all_active
      return Curso.where(:active => true).all
    end

	def alumnos
		alumnos = Array.new
		alumnos_ids = AlumnoCurso.where(:curso_id => self).select(:alumno_id).group(:alumno_id).collect{|p| p.alumno_id}
		alumnos_ids.each do |alumno_id|
	      alumno = Alumno.find(alumno_id)
	      alumnos.push alumno
	    end
	    return alumnos.sort_by{|e| e[:apellido_paterno]}
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

	def relator_codigo
		return User.find(self.relator_jefe_id).name + " - " + self.codigo
	end

	def relator
		return User.find(self.relator_jefe_id).name
	end

	def asistencia
		sesiones_con_asistencia = 0
		sumatoria = 0
		self.sesions.each do |sesion|
			porcentaje_asistentes = sesion.porcentaje_asistentes
			if porcentaje_asistentes == "NA"
				#no hacer nada
			else
				sumatoria += porcentaje_asistentes
				sesiones_con_asistencia += 1
			end
		end
		if sesiones_con_asistencia != 0 
			return ((sumatoria/sesiones_con_asistencia).round(2)).to_i
		else
			return "NA"
		end
	end

	def asistencia_sobre_el_total
		sesiones = 0
		sesiones_sin_asistencia = 0
		sumatoria = 0
		self.sesions.each do |sesion|
			porcentaje_asistentes = sesion.porcentaje_asistentes
			if porcentaje_asistentes == "NA"
				sesiones_sin_asistencia += 1
			else
				sumatoria += porcentaje_asistentes		
			end
			sesiones += 1
		end
		if sesiones != 0 
			if sesiones != sesiones_sin_asistencia
				return ((sumatoria/sesiones).round(2)).to_i
			else
				return "NA"
			end
		else
			return "NA"
		end
	end

	def proxima_sesion
		if self.sesions.any?
			return self.sesions.where(:active => true).where('fecha > ?', DateTime.now).order(:fecha).first
		else
			return nil
		end
	end

	def formularios_contestados
		contador = 0
		FormularioCurso.where(:curso_id => self).all.each do |formulario_curso|
			unless formulario_curso.nil?
				if formulario_curso.contestado?
					contador = contador +  1
				end
			end
		end
		return contador
	end

	def formularios_pendientes
		contador = 0
		FormularioCurso.where(:curso_id => self).all.each do |formulario_curso|
			unless formulario_curso.nil?
				if formulario_curso.pendiente?
					contador = contador +  1
				end
			end
		end
		return contador
	end

	def formularios_no_asignados
		formularios = Formulario.all.count
		return formularios - self.formularios_contestados - self.formularios_pendientes
	end
end
