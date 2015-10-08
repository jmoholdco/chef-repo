require_relative './utils'

module SSLCertsCookbook
  module Helpers
    def self.included(_)
      require 'openssl' unless defined?(OpenSSL)
    end

    def key_length_valid?(number)
      number >= 1024 && number & (number - 1) == 0
    end

    def key_file_valid?(key_file_path, key_password = nil)
      return false unless File.exist?(key_file_path)
      key = OpenSSL::PKey::RSA.new File.read(key_file_path), key_password
      key.private?
    end

    def gen_rsa(bits, password = nil)
      fail InvalidKeyLengthError unless key_length_valid?(bits)
      SSLCertsCookbook::Utils::Key.new(bits: bits, password: password)
    end

    def encrypt_rsa_key(rsa_key, password)
      rsa_key = rsa_key.is_a?(OpenSSL::PKey::RSA) ? rsa_key : rsa_key.ssl
      fail InvalidKeyTypeError unless rsa_key.is_a?(OpenSSL::PKey::RSA)
      fail InvalidPasswordTypeError unless password.is_a?(String)
      cipher = OpenSSL::Cipher::Cipher.new('des3')
      rsa_key.to_pem(cipher, password)
    end

    def load_rsa_key(key_file, password = nil)
      SSLCertsCookbook::Utils::Key.load(key_file, password)
    end

    def resource_key(key_file, new_resource)
      if key_file_valid?(key_file, new_resource.key_pass)
        load_rsa_key(key_file, new_resource.key_pass)
      else
        gen_rsa(new_resource.bits, new_resource.key_pass)
      end
    end

    def resource_subject(new_resource)
      {
        country: new_resource.country,
        state: new_resource.state,
        city: new_resource.city,
        organization: new_resource.org,
        department: new_resource.org_unit,
        common_name: new_resource.common_name,
        email: new_resource.email
      }
    end

    def resource_csr(key, subject)
      SSLCertsCookbook::Utils::SigningRequest.new(key: key, name: subject)
    end
  end

  class InvalidKeyLengthError < ArgumentError
    def message
      'Key length (bits) must be a power of two greater than or equal to 1024'
    end
  end

  class InvalidKeyTypeError < TypeError
    def message
      'rsa_key must be a Ruby OpenSSL::PKey::RSA object'
    end
  end

  class InvalidPasswordTypeError < TypeError
    def message
      'RSA key password must be a string'
    end
  end
end
