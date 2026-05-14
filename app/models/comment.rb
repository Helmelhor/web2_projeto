class Comment < ApplicationRecord
  belongs_to :quadra
  belongs_to :user

  # Respostas (Autorelacionamento)
  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: "parent_id", dependent: :destroy

  # Comentários também recebem likes
  has_many :likes, as: :likeable, dependent: :destroy
end
