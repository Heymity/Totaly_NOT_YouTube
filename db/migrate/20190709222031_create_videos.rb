class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.text :video_text
      t.string :title
      t.string :description
      t.integer :views
      t.date :date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
