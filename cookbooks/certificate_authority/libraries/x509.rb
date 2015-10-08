module SSLCertsCookbook
  module X509
    def self.included(base)
      require 'openssl' unless defined?(OpenSSL)
      base.send(:include, Helpers)
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

    module Helpers
      def key_length_valid?(number)
        number >= 1024 && number & (number - 1) == 0
      end

      def key_file_valid?(key_file_path, key_password = nil)
        return false unless File.exist?(key_file_path)
        key = OpenSSL::PKey::RSA.new File.read(key_file_path), key_password
        key.private?
      end

      def gen_rsa(bits)
        fail InvalidKeyLengthError unless key_length_valid?(bits)
        OpenSSL::PKey::RSA.new(bits)
      end

      def encrypt_rsa_key(rsa_key, password)
        fail InvalidKeyTypeError unless rsa_key.is_a?(OpenSSL::PKey::RSA)
        fail InvalidPasswordTypeError unless password.is_a?(String)
        cipher = OpenSSL::Cipher::Cipher.new('des3')
        rsa_key.to_pem(cipher, key_password)
      end
    end
  end
end
