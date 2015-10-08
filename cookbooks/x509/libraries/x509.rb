begin
  require 'eassl'
  require 'securerandom'
rescue LoadError, NameError => ex
  Chef::Log.warn("x509 library dependency 'eassl' was unable to load. (#{e})")
end

module X509
  class << self
    def generate_key(bits)
      EaSSL::Key.new(bits: bits)
    end

    def x509_load_key(path)
      EaSSL::Key.load(path)
    end

    def generate_csr(key, name)
      ea_name = EaSSL::Certificate.new(name)
      EaSSL::SigningRequest.new(name: ea_name, key: key)
    end

    def issue_self_signed_cert(csr, type, name)
      rand = SecureRandom.urlsafe_base64
      name[:common_name] = "Temporary CA #{rand}"
      ca = EaSSL::CertificateAuthority.new(name: name)
      cert = EaSSL::Certificate.new(
        type: type,
        signing_request: csr,
        ca_certificate: ca.certificate
      )
      cert.sign(ca.key)
    end

    def verify_key_cert_match(key_text, cert_text)
      key = OpenSSL::PKey::RSA.new(key_text)
      cert = OpenSSL::X509::Certificate.new(cert_text)
      key.n == cert.public_key.n
    end
  end
end
