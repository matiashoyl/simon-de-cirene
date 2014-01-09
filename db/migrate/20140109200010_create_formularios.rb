class CreateFormularios < ActiveRecord::Migration
  def change
    create_table :formularios do |t|
      t.string :codigo
      t.string :nombre
      t.string :cuerpo

      t.timestamps
    end
  end
end
