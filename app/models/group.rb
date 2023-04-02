class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users

  has_one_attached :group_image

  def group_exisits?(user)
    group_users.where(user_id: user.id).exists?
  end

  def get_group_image(weight, height)
    unless self.group_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      group_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    self.group_image.variant(resize_to_fill: [weight,height]).processed
  end
end
