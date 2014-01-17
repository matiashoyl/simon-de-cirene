class CreateMensajes < ActiveRecord::Migration
  def change
    create_table :mensajes do |t|
      t.string :titulo
      t.string :cuerpo
      t.string :caracter

      t.timestamps
    end
  end
end
