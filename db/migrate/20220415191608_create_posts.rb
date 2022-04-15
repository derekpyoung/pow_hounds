class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :title
      t.integer :runs_taken
      t.string :snow
      t.string :weather
      t.string :description
      t.string :resort
      t.string :photo
      t.string :awards

      t.timestamps
    end
  end
end
