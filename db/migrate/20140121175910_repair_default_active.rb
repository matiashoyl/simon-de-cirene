class RepairDefaultActive < ActiveRecord::Migration
  def change
  	change_column :programas, :active, :boolean, :default => true
  	change_column :cursos, :active, :boolean, :default => true
  	change_column :sesions, :active, :boolean, :default => true
  end
end
