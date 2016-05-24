class Post < ActiveRecord::Base
  validates :message, presence: true
  validates :picture, presence: true
  has_many :comments
  has_many :related_recipes

  belongs_to :user
  mount_uploader :picture, PictureUploader
end
