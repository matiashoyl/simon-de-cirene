class Alumno < ActiveRecord::Base
  
	attr_accessible :nombre, :apellido_paterno, :apellido_materno, :rut, :quintil, :direccion, :comuna, :num_telefono, :num_celular, :fecha_nacimiento, :sexo, :email, :escolaridad, :profesion, :actividad, :cargo, :rut_institucion

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
				alumno = find_by_id(row["id"]) || new
				alumno.attributes = row.to_hash.slice(*accessible_attributes)
				alumno.save
				AlumnoCurso.create(:alumno_id => alumno.id, :curso_id => cursoId)
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

	def cursos
		cursos = Array.new
		curso_ids = AlumnoCurso.where(:alumno_id => self).select(:curso_id).group(:curso_id).collect{|p| p.curso_id}
		curso_ids.each do |curso_id|
			cursos.push Curso.find(curso_id)
		end
		return cursos
	end

	def sesiones
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
end
