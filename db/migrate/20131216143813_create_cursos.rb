class CreateCursos < ActiveRecord::Migration
  def change
    create_table :cursos do |t|
      t.string :codigo
      t.string :nombre
      t.string :comuna

      t.timestamps
    end
  end
end
