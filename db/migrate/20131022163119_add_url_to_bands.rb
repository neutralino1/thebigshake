class AddUrlToBands < ActiveRecord::Migration
  def change
    add_column :bands, :url, :string
    Band.initialize_urls
  end
end
