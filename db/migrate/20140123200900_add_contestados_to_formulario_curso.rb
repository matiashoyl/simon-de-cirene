class AddContestadosToFormularioCurso < ActiveRecord::Migration
  def change
  	add_column :formulario_cursos, :contestados, :integer, :default => 0
  end
end
