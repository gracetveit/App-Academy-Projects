class AddPremiumToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :premium, :boolean, null:false, default:false
  end
end
