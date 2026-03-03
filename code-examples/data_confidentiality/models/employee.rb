require "bcrypt"
require_relative "../helpers/security"

# Model class for customers
class Employee < Sequel::Model
  ENCRYPTION_KEY = OpenSSL::Cipher.new('AES-256-CBC').random_key

  def signup(params)
    username = params.fetch("username", "").strip
    errors.add("username", "cannot be empty") if username.empty?
    errors.add("username", "already taken") unless Employee.first(username: username).nil?
    password = params.fetch("password", "").strip
    errors.add("password", "cannot be empty") if password.empty?
    ni_number = params.fetch("ni_number", "").strip
    errors.add("ni_number", "cannot be empty") if ni_number.empty?
    return false unless errors.empty?

    self.username = username
    self.password = password # Uses the password= setter
    self.ni_number = ni_number # Uses the ni_number= setter

    true
  end

  def ni_number
    Security.decrypt(encrypted_ni_number, encryption_iv, encryption_tag)
  end

  def ni_number=(plaintext_ni)
    result = Security.encrypt(plaintext_ni)
    self.encrypted_ni_number = result[:data]
    self.encryption_iv = result[:iv]
    self.encryption_tag = result[:tag]
  end

  def password=(plaintext_password)
    self.password_hash = BCrypt::Password.create(plaintext_password)
  end

  def authenticate(password_attempt)
    BCrypt::Password.new(password_hash) == password_attempt
  end
end
