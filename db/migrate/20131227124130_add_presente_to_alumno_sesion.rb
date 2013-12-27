class AddPresenteToAlumnoSesion < ActiveRecord::Migration
  def change
  	add_column :alumno_sesions, :presente, :boolean
  end
end
