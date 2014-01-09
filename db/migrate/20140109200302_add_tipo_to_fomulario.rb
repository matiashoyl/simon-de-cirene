class AddTipoToFomulario < ActiveRecord::Migration
  def change
  	add_column :formularios, :tipo, :string
  end
end
