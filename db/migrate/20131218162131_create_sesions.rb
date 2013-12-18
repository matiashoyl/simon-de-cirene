class CreateSesions < ActiveRecord::Migration
  def change
    create_table :sesions do |t|
      t.string :tema
      t.time :hora_inicio
      t.time :hora_termino
      t.datetime :fecha
      t.string :tipo
      t.string :direccion
      t.string :comentario

      t.timestamps
    end
  end
end
