class RestructureUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :email
    rename_column :users, :name, :username
  end
end
