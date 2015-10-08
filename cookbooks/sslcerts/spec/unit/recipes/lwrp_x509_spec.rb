require 'spec_helper'

RSpec.describe 'test::lwrp_x509' do
  context 'When all attributes are default, on an unspecifed platform:' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(step_into: ['sslcerts_x509'])
      runner.converge(described_recipe)
    end

    it 'adds file resource `/etc/ssl_test/mycert.crt` with action delete' do
      expect(chef_run).to delete_file('Any potential existing cert')
    end

    it 'adds file resource `/etc/ssl_test/mycert.crt` with action delete' do
      expect(chef_run).to delete_file('Any potential existing cert')
    end

    it 'adds file resource `/etc/ssl_test/mycert.key` with action delete' do
      expect(chef_run).to delete_file('Any potential existing key')
    end

    it 'adds file resource `/etc/ssl_test/mycert2.crt` with action delete' do
      expect(chef_run).to delete_file('Any potential existing second cert')
    end

    it 'adds directory resource `/etc/ssl_test` with action create' do
      expect(chef_run).to create_directory('/etc/ssl_test')
    end

    it 'adds openssl_x509 resource `/etc/ssl_test/mycert.crt` action :create' do
      expect(chef_run).to create_x509_certificate('/etc/ssl_test/mycert.crt')
    end

    describe 'The LWRP' do
      it 'adds file resource `/etc/ssl_test/mycert.crt` :create_if_missing' do
        expect(chef_run).to create_file_if_missing('/etc/ssl_test/mycert.crt')
      end

      it 'adds file resource `/etc/ssl_test/mycert.key` :create_if_missing' do
        expect(chef_run).to create_file_if_missing('/etc/ssl_test/mycert.key')
      end
    end
  end
end
