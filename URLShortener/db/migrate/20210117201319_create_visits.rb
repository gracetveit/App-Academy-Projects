class CreateVisits < ActiveRecord::Migration[6.1]
  def change
    create_table :visits do |t|
      t.integer :num_visits, null:false
      t.integer :shortened_url_id, null:false
      t.integer :user_id, null:false
      t.timestamps
    end

    add_index :visits, :shortened_url_id, unique: true
    add_index :visits, :user_id
  end
end
