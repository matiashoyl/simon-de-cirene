class CreateMensajeUsuarios < ActiveRecord::Migration
  def change
    create_table :mensaje_usuarios do |t|
      t.integer :mensaje_id
      t.integer :usuario_id

      t.timestamps
    end
  end
end
