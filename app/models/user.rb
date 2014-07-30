class User < ActiveRecord::Base
	validates :username, presence: true, uniqueness: true,
      format: { with: /\A\w+\z/ }
  validates :email, presence: true, uniqueness: { case_sensitive: false },
      format: { with: /@/ }
	has_secure_password
end
