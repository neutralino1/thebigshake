class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :name, null: false
      t.text :bio
      t.attachment :thumbnail
      t.attachment :picture
      t.string :facebook
      t.string :twitter
      t.string :link
      t.integer :track_id
    end
  end
end
