class AddRelatorjefeToCurso < ActiveRecord::Migration
  def change
  	add_column :cursos, :relator_jefe_id, :integer
  end
end
