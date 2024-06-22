class CreateAchievementsUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :achievements_users do |t|
      t.integer :user_id
      t.integer :achievements_id

      t.timestamps
    end
  end
end
