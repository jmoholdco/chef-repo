module CertificateAuthorityCookbook
  module Utils
    class IntermediateCA
      def initialize(options = {})
        return load_from_file(options) if options[:key_file] || options[:key]
        start_fresh(options)
      end

      def load_from_file(options = {})
        key_text = File.read(options[:key]) if pem_exists(options[:key])
        cert_text = File.read(options[:cert]) if pem_exists(options[:cert])
        return unless key_text && cert_text
        @key = OpenSSL::PKey::RSA.new key_text, options[:password]
        @cert = OpenSSL::X509::Certificate.new cert_text
      end

      def start_fresh(options)
        @key ||= OpenSSL::PKey::RSA.new options[:bits]
      end

      def pem_exists?(pem_path = nil)
        pem_path && File.exist?(pem_path)
      end
    end
  end
end
