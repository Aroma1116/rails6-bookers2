class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50}
  validates :postal_code, presence: true
  validates :address, presence: true

  include JpPrefecture
  jp_prefecture :prefecture_code


  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  geocoded_by :address
  after_validation :geocode, if: :address_changed?


  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

end
