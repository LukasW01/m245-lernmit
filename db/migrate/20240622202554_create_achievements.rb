class CreateAchievements < ActiveRecord::Migration[7.1]
  def change
    create_table :achievements do |t|
      t.string :image
      t.string :title

      t.timestamps
    end
  end
end
