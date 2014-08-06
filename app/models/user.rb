class User < ActiveRecord::Base
	validates :username, presence: true, uniqueness: true, length: { maximum: 20 },
      format: { with: /\A\w+\z/, message: "must only consist of alphanumeric characters (A-Z, 0-9) or underscores (_)" }
  validates :email, presence: true, uniqueness: { case_sensitive: false },
      format: { with: /@/ }
	has_secure_password

  has_many :posts, dependent: :destroy
end
