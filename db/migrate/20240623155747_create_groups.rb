class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :desc
      t.integer :size

      t.timestamps
    end
  end
end
