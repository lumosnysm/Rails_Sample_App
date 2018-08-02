class Micropost < ApplicationRecord
  mount_uploader :picture, PictureUploader

  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.content_max_length}
  validate  :picture_size

  scope :latest, ->{order created_at: :desc}

  private

  def picture_size
    if picture.size > Settings.image_size.megabytes
      errors.add :picture, I18n.t(".err")
    end
  end
end
