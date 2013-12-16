class CreateCursos < ActiveRecord::Migration
  def change
    create_table :cursos do |t|
      t.string :codigo
      t.string :nombre
      t.datetime :fecha_inicio
      t.datetime :fecha_termino

      t.timestamps
    end
  end
end
