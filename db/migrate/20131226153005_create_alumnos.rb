class CreateAlumnos < ActiveRecord::Migration
  def change
    create_table :alumnos do |t|
      t.string :nombre
      t.string :rut

      t.timestamps
    end
  end
end
