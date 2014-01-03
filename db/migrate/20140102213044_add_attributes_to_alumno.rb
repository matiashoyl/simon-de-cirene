class AddAttributesToAlumno < ActiveRecord::Migration
  def change
  	add_column :alumnos, :quintil, :string
  	add_column :alumnos, :direccion, :string
  	add_column :alumnos, :comuna, :string
  	add_column :alumnos, :num_telefono, :string
  	add_column :alumnos, :num_celular, :string
  	add_column :alumnos, :fecha_nacimiento, :date
  	add_column :alumnos, :sexo, :string
  	add_column :alumnos, :email, :string
  	add_column :alumnos, :escolaridad, :string
  	add_column :alumnos, :profesion, :string
  	add_column :alumnos, :actividad, :string
  	add_column :alumnos, :cargo, :string
  	add_column :alumnos, :rut_institucion, :string
  end
end
