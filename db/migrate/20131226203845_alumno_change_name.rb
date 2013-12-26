class AlumnoChangeName < ActiveRecord::Migration
  def change
  	add_column :alumnos, :apellido_paterno, :string
  	add_column :alumnos, :apellido_materno, :string
  end
end
