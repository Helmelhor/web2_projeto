class User < ApplicationRecord
  has_secure_password

  validates :nome, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :quadras, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def liked?(item)
    likes.exists?(likeable: item)
  end
end
