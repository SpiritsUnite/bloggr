class Post < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 50 }
  belongs_to :user
end
