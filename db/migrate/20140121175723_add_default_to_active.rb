class AddDefaultToActive < ActiveRecord::Migration
  def change
  	change_column :programas, :active, :boolean, :default => false
  	change_column :cursos, :active, :boolean, :default => false
  	change_column :sesions, :active, :boolean, :default => false
  end
end
