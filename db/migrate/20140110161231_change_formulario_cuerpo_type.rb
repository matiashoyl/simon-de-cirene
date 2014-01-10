class ChangeFormularioCuerpoType < ActiveRecord::Migration
  def change
  	change_column :formularios, :cuerpo, :text
  end
end
