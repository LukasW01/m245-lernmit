class CreateAchievements < ActiveRecord::Migration[7.1]
  def change
    create_table :achievements do |t|
      t.string :name
      t.integer :user_id
      t.timestamps
    end

    add_index :achievements, :user_id
  end
end
