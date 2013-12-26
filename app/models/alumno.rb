class Alumno < ActiveRecord::Base
  attr_accessible :nombre, :rut

  validates :nombre, :rut, :presence => true

	def self.import(file, cursoId)
		spreadsheet = open_spreadsheet(file)
		header = spreadsheet.row(1)
		(2..spreadsheet.last_row).each do |i|
			row = Hash[[header, spreadsheet.row(i)].transpose]
			alumno = find_by_id(row["id"]) || new
			alumno.attributes = row.to_hash.slice(*accessible_attributes)
			alumno.save
			AlumnoCurso.create(:alumno_id => alumno.id, :curso_id => cursoId)
		end
	end

	def self.open_spreadsheet(file)
		case File.extname(file.original_filename)
		when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
		when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
		when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
		else raise "Formato de archivo desconocido: #{file.original_filename}"
		end
	end
end
