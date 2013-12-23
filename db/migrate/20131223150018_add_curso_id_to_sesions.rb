class AddCursoIdToSesions < ActiveRecord::Migration
  def change
  	add_column :sesions, :curso_id, :integer
  end
end
