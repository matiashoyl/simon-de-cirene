class AddActiveToAll < ActiveRecord::Migration
  def change
  	add_column :cursos, :active, :boolean
  	add_column :sesions, :active, :boolean
  end
end
