class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :user_id, presence: true
  validates :content, presence: true,
  length: {maximum: Settings.variable_length.micropost}
  validates :image,
            content_type: {in: Settings.format.image,
                           message: I18n.t("text.image_valid_form")}
  validate :image_size
  delegate :name, to: :user, prefix: :user

  scope :order_by_created, ->{order(created_at: :desc)}
  scope :by_id, ->(id){where(user_id: id)}

  def display_image
    image.variant(resize_to_limit: [Settings.size.image, Settings.size.image])
  end

  def image_size
    return if image.blank?

    errorMsg = I18n.t("text.file_size")
    if image.byte_size > Settings.size.image_size.megabytes
      errors.add(:image, errorMsg)
    end
  end
end
