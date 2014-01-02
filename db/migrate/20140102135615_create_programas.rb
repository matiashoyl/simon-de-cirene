class CreateProgramas < ActiveRecord::Migration
  def change
    create_table :programas do |t|
      t.string :nombre
      t.string :tipo

      t.timestamps
    end
  end
end
