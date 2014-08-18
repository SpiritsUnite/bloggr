class Post < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 50 }
  validates :author_id, presence: true
  belongs_to :author, class_name: "User"
  has_many :comments, dependent: :destroy
end
