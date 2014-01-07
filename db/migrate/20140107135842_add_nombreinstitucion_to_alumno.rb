class AddNombreinstitucionToAlumno < ActiveRecord::Migration
  def change
  	add_column :alumnos, :nombre_institucion, :string
  end
end
