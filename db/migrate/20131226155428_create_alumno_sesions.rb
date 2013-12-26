class CreateAlumnoSesions < ActiveRecord::Migration
  def change
    create_table :alumno_sesions do |t|
      t.integer :alumno_id
      t.integer :sesion_id
      
      t.timestamps
    end
  end
end
