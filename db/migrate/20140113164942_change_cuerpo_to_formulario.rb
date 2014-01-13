class ChangeCuerpoToFormulario < ActiveRecord::Migration
  def change
  	change_column :formularios, :cuerpo, :string
  	rename_column :formularios, :cuerpo, :url
  end
end
