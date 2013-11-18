class AddPlayCountToBands < ActiveRecord::Migration
  def change
    add_column :bands, :play_count, :integer, default: 0
  end
end
