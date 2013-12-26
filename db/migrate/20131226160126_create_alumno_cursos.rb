class CreateAlumnoCursos < ActiveRecord::Migration
  def change
    create_table :alumno_cursos do |t|
	  t.integer :alumno_id
      t.integer :curso_id
      
      t.timestamps
    end
  end
end
