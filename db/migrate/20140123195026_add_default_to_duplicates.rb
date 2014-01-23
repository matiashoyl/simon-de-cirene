class AddDefaultToDuplicates < ActiveRecord::Migration
  def change
  	change_column :formulario_cursos, :duplicates, :integer, :default => 1
  end
end
