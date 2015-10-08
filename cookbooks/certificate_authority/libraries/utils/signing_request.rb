module CertificateAuthorityCookbook
  module Utils
    class SigningRequest
      extend Forwardable

      attr_reader :key, :ssl

      def initialize(options = {})
        options = { name: {}, key: nil }.update(options)
        @key = options[:key] || Key.new(options)
        @ssl = generate_csr(options[:name])
      end

      def_delegator :@ssl, :to_pem, :to_pem

      private

      def generate_csr(name_opts)
        OpenSSL::X509::Request.new.tap do |req|
          req.version = 2
          req.subject = CertificateName.new(name_opts).name
          req.public_key = key.public_key
          req.sign(key.private_key, OpenSSL::Digest::SHA256.new)
        end
      end
    end
  end
end
