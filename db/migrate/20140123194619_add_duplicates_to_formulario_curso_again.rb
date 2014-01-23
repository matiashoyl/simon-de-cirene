class AddDuplicatesToFormularioCursoAgain < ActiveRecord::Migration
  def change
  	add_column :formulario_cursos, :duplicates, :integer
  end
end
