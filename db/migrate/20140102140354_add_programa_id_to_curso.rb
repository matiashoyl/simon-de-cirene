class AddProgramaIdToCurso < ActiveRecord::Migration
  def change
  	add_column :cursos, :programa_id, :integer
  end
end
