class CreateFormularioCursos < ActiveRecord::Migration
  def change
    create_table :formulario_cursos do |t|
      t.integer :formulario_id
      t.integer :curso_id
      t.string :estado

      t.timestamps
    end
  end
end
