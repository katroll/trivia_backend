class User < ApplicationRecord
  validates :username, uniqueness: true
  validates_presence_of :username, :first_name, :last_name

  has_secure_password
  
  def password=(new_password)
      salt = BCrypt::Engine::generate_salt
      self.password_digest = BCrypt::Engine::hash_secret(new_password, salt)
  end

  def authenticate(password)
      salt = password_digest[0..28]
      return nil unless BCrypt::Engine::hash_secret(password, salt) == self.password_digest
      self
  end

end
