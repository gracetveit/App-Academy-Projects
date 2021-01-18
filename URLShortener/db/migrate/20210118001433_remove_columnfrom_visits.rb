class RemoveColumnfromVisits < ActiveRecord::Migration[6.1]
  def change
    remove_column :visits, :num_visits 
  end
end
