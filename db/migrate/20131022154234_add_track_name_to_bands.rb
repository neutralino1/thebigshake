class AddTrackNameToBands < ActiveRecord::Migration
  def change
    add_column :bands, :track_name, :string
  end
end
