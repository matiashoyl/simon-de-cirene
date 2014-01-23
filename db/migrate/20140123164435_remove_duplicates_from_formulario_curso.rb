class RemoveDuplicatesFromFormularioCurso < ActiveRecord::Migration
  def change
  	remove_column :formulario_cursos, :duplicates
  end
end
