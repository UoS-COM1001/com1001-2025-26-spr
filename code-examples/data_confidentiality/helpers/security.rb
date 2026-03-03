require "openssl"
require "fileutils"

module Security
  KEY_FILE = "config/master_key.txt".freeze

  def self.ensure_key!
    return if File.exist?(KEY_FILE)

    FileUtils.mkdir_p("config")
    key = OpenSSL::Random.random_bytes(32)
    File.write(KEY_FILE, key.unpack1("H*"))
    File.chmod(0o600, KEY_FILE)
  end

  def self.master_key
    ensure_key!
    [File.read(KEY_FILE).strip].pack("H*")
  end

  def self.encrypt(plaintext)
    return { data: nil, iv: nil, tag: nil } if plaintext.nil?

    cipher = OpenSSL::Cipher.new("AES-256-GCM")
    cipher.encrypt
    cipher.key = master_key
    iv = cipher.random_iv
    cipher.iv = iv
    data = cipher.update(plaintext) + cipher.final
    tag = cipher.auth_tag
    { data: data, iv: iv, tag: tag }
  end

  def self.decrypt(encrypted_data, iv, tag)
    return nil if encrypted_data.nil? || iv.nil? || tag.nil?

    cipher = OpenSSL::Cipher.new("AES-256-GCM")
    cipher.decrypt
    cipher.key = master_key
    cipher.iv = iv
    cipher.auth_tag = tag
    cipher.update(encrypted_data) + cipher.final
  end
end
