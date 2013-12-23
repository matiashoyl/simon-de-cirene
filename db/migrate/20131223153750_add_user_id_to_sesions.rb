class AddUserIdToSesions < ActiveRecord::Migration
  def change
  	add_column :sesions, :user_id, :integer
  end
end
