class Comment < ApplicationRecord
  belongs_to :quadra
  belongs_to :user
end
