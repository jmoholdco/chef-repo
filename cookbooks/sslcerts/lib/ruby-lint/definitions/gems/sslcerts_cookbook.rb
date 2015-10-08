# This file was automatically generated, any manual changes will be lost the
# next time this file is generated.
#
# Platform: ruby 2.1.6

RubyLint.registry.register('SSLCertsCookbook::Utils') do |defs|
  defs.define_constant('SSLCertsCookbook::Utils') do |klass|
    klass.inherits(defs.constant_proxy('Object', RubyLint.registry))

  end

  defs.define_constant('SSLCertsCookbook::Utils::AuthorityCertificate') do |klass|
    klass.inherits(defs.constant_proxy('Object', RubyLint.registry))

    klass.define_instance_method('initialize') do |method|
      method.define_argument('options')

      method.returns { |object| object.instance }
    end
  end

  defs.define_constant('SSLCertsCookbook::Utils::Certificate') do |klass|
    klass.inherits(defs.constant_proxy('Object', RubyLint.registry))
    klass.inherits(defs.constant_proxy('SSLCertsCookbook::Utils::Delegation', RubyLint.registry))

    klass.define_instance_method('initialize') do |method|
      method.define_argument('options')

      method.returns { |object| object.instance }
    end

    klass.define_instance_method('sha256_fingerprint')

    klass.define_instance_method('sign') do |method|
      method.define_argument('ca_key')
    end

    klass.define_instance_method('ssl')

    klass.define_instance_method('to_pem') do |method|
      method.define_rest_argument('args')
      method.define_block_argument('block')
    end
  end

  defs.define_constant('SSLCertsCookbook::Utils::CertificateName') do |klass|
    klass.inherits(defs.constant_proxy('Object', RubyLint.registry))

    klass.define_instance_method('initialize') do |method|
      method.define_argument('options')

      method.returns { |object| object.instance }
    end

    klass.define_instance_method('name')

    klass.define_instance_method('options')

    klass.define_instance_method('ssl')
  end

  defs.define_constant('SSLCertsCookbook::Utils::Delegation') do |klass|
    klass.inherits(defs.constant_proxy('Object', RubyLint.registry))

    klass.define_method('included') do |method|
      method.define_argument('base')
    end

    klass.define_instance_method('method_missing') do |method|
      method.define_argument('meth')
      method.define_rest_argument('args')
    end

    klass.define_instance_method('respond_to?') do |method|
      method.define_argument('meth')
    end
  end

  defs.define_constant('SSLCertsCookbook::Utils::IntermediateCA') do |klass|
    klass.inherits(defs.constant_proxy('Object', RubyLint.registry))

    klass.define_method('load') do |method|
      method.define_argument('options')
    end

    klass.define_instance_method('create_certificate') do |method|
      method.define_argument('csr')
      method.define_optional_argument('type')
      method.define_optional_argument('days_valid')
    end

    klass.define_instance_method('initialize') do |method|
      method.define_optional_argument('options')

      method.returns { |object| object.instance }
    end

    klass.define_instance_method('load_from_file') do |method|
      method.define_optional_argument('options')
    end

    klass.define_instance_method('start_fresh') do |method|
      method.define_argument('options')
    end
  end

  defs.define_constant('SSLCertsCookbook::Utils::Key') do |klass|
    klass.inherits(defs.constant_proxy('Object', RubyLint.registry))

    klass.define_method('load') do |method|
      method.define_argument('pem_file_path')
      method.define_optional_argument('password')
    end

    klass.define_instance_method('initialize') do |method|
      method.define_optional_argument('options')

      method.returns { |object| object.instance }
    end

    klass.define_instance_method('length')

    klass.define_instance_method('load') do |method|
      method.define_argument('pem_string')
      method.define_optional_argument('pass')
    end

    klass.define_instance_method('method_missing') do |method|
      method.define_argument('meth')
      method.define_rest_argument('args')
    end

    klass.define_instance_method('private_key')

    klass.define_instance_method('public_key') do |method|
      method.define_rest_argument('args')
      method.define_block_argument('block')
    end

    klass.define_instance_method('ssl')

    klass.define_instance_method('to_pem')
  end

  defs.define_constant('SSLCertsCookbook::Utils::SigningRequest') do |klass|
    klass.inherits(defs.constant_proxy('Object', RubyLint.registry))
    klass.inherits(defs.constant_proxy('SSLCertsCookbook::Utils::Delegation', RubyLint.registry))

    klass.define_instance_method('initialize') do |method|
      method.define_optional_argument('options')

      method.returns { |object| object.instance }
    end

    klass.define_instance_method('key')

    klass.define_instance_method('ssl')

    klass.define_instance_method('to_pem') do |method|
      method.define_rest_argument('args')
      method.define_block_argument('block')
    end
  end
end
