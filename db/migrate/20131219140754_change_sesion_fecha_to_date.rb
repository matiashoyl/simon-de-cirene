class ChangeSesionFechaToDate < ActiveRecord::Migration
  def change
  	change_column :sesions, :fecha, :date
  end
end
