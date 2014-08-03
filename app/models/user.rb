class User < ActiveRecord::Base
	validates :username, presence: true, uniqueness: true, length: { maximum: 20 },
      format: { with: /\A\w+\z/ }
  validates :email, presence: true, uniqueness: { case_sensitive: false },
      format: { with: /@/ }
	has_secure_password

  has_many :posts, dependent: :destroy
end
