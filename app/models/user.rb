class User < ActiveRecord::Base
  before_save { email.downcase! }
  has_secure_password

  # Validations
  validates :name, presence: true,
                   length: { maximum: 60 }
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: /\A[\w+.]+@[\w\-.]+\.[a-z]+\z/i }

  validates :password, length: { minimum: 6 }

end
