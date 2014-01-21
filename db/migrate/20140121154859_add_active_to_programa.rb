class AddActiveToPrograma < ActiveRecord::Migration
  def change
  	add_column :programas, :active, :boolean
  end
end
