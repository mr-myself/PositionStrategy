class PasswordBuilder
  require 'digest/sha2'

  class << self
    def to_sha512(plain_password)
      Digest::SHA512.hexdigest(plain_password)
    end
  end
end
