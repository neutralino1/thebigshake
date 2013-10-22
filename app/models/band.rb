class Band < ActiveRecord::Base

  rails_admin do
    edit do
      field :name
      field :track_id
      field :track_name
      field :bio
      field :thumbnail
      field :picture
      field :facebook
      field :twitter
      field :link
    end
  end

  if Rails.env.development?
    has_attached_file :picture
    has_attached_file :thumbnail
  else
    has_attached_file :picture, storage: :s3,
      s3_credentials: Rails.root.join("config", "s3.yml"),
      path: "/bands/:id/picture/:filename",
      url: ":s3_eu_url"
    has_attached_file :thumbnail, storage: :s3,
      s3_credentials: Rails.root.join("config", "s3.yml"),
      path: "/bands/:id/thumbnail/:filename",
      url: ":s3_eu_url"
  end

  validates :name, presence: true

end