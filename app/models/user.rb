class User < ActiveRecord::Base
  before_save { email.downcase! }
  before_create :allot_remmeber_token
  has_secure_password

  # Validations
  validates :name, presence: true,
                   length: { maximum: 60 }
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: /\A[\w+.]+@[\w\-.]+\.[a-z]+\z/i }

  validates :password, length: { minimum: 6 }

  def User.new_random_token
    SecureRandom.urlsafe_base64.to_s
  end

  private
  def allot_remmeber_token
    self.remember_token = Digest::SHA1.hexdigest(User.new_random_token)
  end

end
