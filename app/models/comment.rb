class Comment < ApplicationRecord
  default_scope { where(deleted_at: nil) }
  mount_uploader :image, ImageUploader
  mount_uploaders :images, ImageUploader
  scope :by_content, ->(content) { where('content LIKE ?', "%#{content}%") }
  validates :content, presence: true
  acts_as_paranoid
  def user_name
    User.find(user_id).name if user_id
  end
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  def self.average_rating
    where.not(rating: nil).average(:rating) || 0
  end
end
