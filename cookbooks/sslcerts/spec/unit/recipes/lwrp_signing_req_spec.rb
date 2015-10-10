require 'spec_helper'

RSpec.describe 'test::lwrp_signing_req' do
  context 'When all attributes are default, on an unspecifed platform:' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(step_into: ['sslcerts_signing_req'])
      runner.converge(described_recipe)
    end

    describe 'the LWRP' do
      it 'adds file resource /etc/ssl_test/myreq.csr' do
        expect(chef_run).to create_file_if_missing('/etc/ssl_test/myreq.csr')
      end

      it 'adds file resource /etc/pki/tls/private/myreq.key' do
        expect(chef_run)
          .to create_file_if_missing('/etc/pki/tls/private/myreq.key')
      end

      it 'adds the csr to the node\'s csr outbox' do
        outbox = chef_run.node['csr_outbox']
        node_name = chef_run.node['fqdn']
        expect(outbox).to_not be_nil
        expect(outbox.length).to be 1
        expect(outbox[node_name]).to_not be_nil
      end
    end
  end
end
