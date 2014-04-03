class MensajeChangeStringToText < ActiveRecord::Migration
  def change
  	change_column :mensajes, :cuerpo, :text
  end
end
