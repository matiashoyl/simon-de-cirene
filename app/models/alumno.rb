class Alumno < ActiveRecord::Base
  	audited

	attr_accessible :nombre, :apellido_paterno, :apellido_materno, :rut, :quintil, :direccion, :comuna, :num_telefono, :num_celular, :fecha_nacimiento, :sexo, :email, :escolaridad, :profesion, :actividad, :cargo, :rut_institucion, :nombre_institucion

	validates :nombre, :apellido_paterno, :rut, :presence => true
	validates :rut, :uniqueness => true

	def self.import(file, cursoId)
		spreadsheet = open_spreadsheet(file)
		if (spreadsheet)
			largo = spreadsheet.last_row
			spreadsheet.default_sheet = spreadsheet.sheets[1]
			header = spreadsheet.row(1)
			(2..largo).each do |i|
				row = Hash[[header, spreadsheet.row(i)].transpose]
				alumno = find_by_rut(row["rut"]) || new
				alumno.attributes = row.to_hash.slice(*accessible_attributes)
				alumno.save
				AlumnoCurso.create(:alumno_id => alumno.id, :curso_id => cursoId)
			end
		end
	end

	def self.import_sence(file)
		spreadsheet = open_spreadsheet(file)
		if (spreadsheet)
			largo = spreadsheet.last_row
			header = spreadsheet.row(1)
			(2..largo).each do |i|
				row = Hash[[header, spreadsheet.row(i)].transpose]
				linea = "" + i.to_s + " / "
				rut_aux = row["Rut Participante"].dup
				alumno = Alumno.where(:rut => Alumno.formato_rut(rut_aux)).first
				linea += rut_aux
				if alumno
					linea += alumno.nombre + " " + alumno.apellido_paterno
					unless row["Fecha Asistencia"].nil?
						fecha = Date.new(row["Fecha Asistencia"].year, row["Fecha Asistencia"].month, row["Fecha Asistencia"].day)
						linea += " / " + fecha.to_s
						aux_hora_inicio = Time.new(2000, 1, 1, 0, 0, 0, 0) + row["Hora Inicio"].hours*60*60 + row["Hora Inicio"].minutes*60 + row["Hora Inicio"].seconds
						hora_inicio = Time.utc(2000, 1, 1, aux_hora_inicio.hour, aux_hora_inicio.min, aux_hora_inicio.sec, 0)
						aux_hora_termino = Time.new(2000, 1, 1, 0, 0, 0, 0) + row["Hora Fin"].hours*60*60 + row["Hora Fin"].minutes*60 + row["Hora Fin"].seconds
						hora_termino = Time.utc(2000, 1, 1, aux_hora_termino.hour, aux_hora_termino.min, aux_hora_termino.sec, 0)
						linea += " / " + hora_inicio.to_s
						linea += " / " + hora_termino.to_s
						sesiones = Sesion.where(:fecha => fecha, :hora_inicio => hora_inicio, :hora_termino => hora_termino, :active => true).all
						if sesiones.any?
							sesion_aux = nil
							sesiones.each do |sesion|
								if sesion.curso.comuna == row["Comuna"]
									sesion_aux = sesion
								end
							end
						end
						unless sesion_aux.nil?
							if row["Estado Asistencia"] == "Asistio"
								ac = AlumnoSesion.where(:alumno_id => alumno.id, :sesion_id => sesion_aux.id).first_or_create
								ac.update_attributes(:presente => true)
							elsif row["Estado Asistencia"] == "No Asistio"
								ac = AlumnoSesion.where(:alumno_id => alumno.id, :sesion_id => sesion_aux.id).first_or_create
								ac.update_attributes(:presente => false)
							end
						end
					end
				end
				puts linea
			end
		end
	end

	def self.open_spreadsheet(file)
		if file
			case File.extname(file.original_filename)
			when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
			when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
			when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
			else raise "Formato de archivo desconocido: #{file.original_filename}"
			end
		end
	end

	def porcentaje_asistencia(curso)
		sesiones = curso.sesions
		asistencias = 0.0
		sesiones_totales = 0.0
		sesiones.each do |sesion|
			if alumno_sesion = AlumnoSesion.where(:alumno_id => self, :sesion_id => sesion).first
				if alumno_sesion.presente
					asistencias = asistencias + 1
				end
				sesiones_totales = sesiones_totales + 1
			end
		end
		porcentaje_asistencia = 0
		begin
			porcentaje_asistencia = ((asistencias/sesiones_totales).round(2)*100).to_i
		rescue 
			porcentaje_asistencia = 0
		end
		if sesiones_totales == 0
			porcentaje_asistencia = "NA"
		end
		return porcentaje_asistencia
	end

	def numero_inasistencias(curso)
		inasistencias = 0
		curso.sesions.each do |sesion|
			if alumno_sesion = AlumnoSesion.where(:alumno_id => self, :sesion_id => sesion).first
				if alumno_sesion.presente == false
					inasistencias = inasistencias + 1
				end
			end
		end
		return inasistencias
	end

	def cursos
		cursos = Array.new
		curso_ids = AlumnoCurso.where(:alumno_id => self).select(:curso_id).group(:curso_id).collect{|p| p.curso_id}
		curso_ids.each do |curso_id|
			if Curso.exists?(curso_id)
				cursos.push Curso.find(curso_id)
			end
		end
		return cursos
	end

	def sesiones_asistidas
		sesiones = Array.new
		sesion_ids = AlumnoSesion.where(:alumno_id => self).select(:sesion_id).group(:sesion_id).collect{|p| p.sesion_id}
		sesion_ids.each do |sesion_id|
			alumno_sesion = AlumnoSesion.where(:alumno_id => self, :sesion_id => sesion_id).first
			if alumno_sesion.presente
				sesiones.push Sesion.find(sesion_id)
			end
		end
		return sesiones.sort_by &:fecha
	end

	def sesiones_totales
		sesiones = Array.new
		sesion_ids = AlumnoSesion.where(:alumno_id => self).select(:sesion_id).group(:sesion_id).collect{|p| p.sesion_id}
		sesion_ids.each do |sesion_id|
			sesiones.push Sesion.find(sesion_id)
		end
		return sesiones.sort_by &:fecha
	end

	def self.formato_rut(rut)
		rut.insert((rut.length - 5), ".").insert((rut.length - 9), ".")
		return rut
	end
end
