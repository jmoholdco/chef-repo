require 'digest/sha2'

include SSLCertsCookbook::Helpers

use_inline_resources

def whyrun_supported?
  true
end

action :create do
  converge_by("Create a Certificate #{@new_resource}") do
    if required_files? && key_cert_match?(private_key, cert_vault[node['fqdn']])
      file new_resource.name do
        owner new_resource.owner
        group new_resource.group
        mode 0644
        action :create_if_missing
        content cert_vault[node['fqdn']]
      end
    end

    if stale_csr? && node.set['csr_outbox'].delete(node['fqdn'])
      new_resource.updated_by_last_action true
    end
  end
end

protected

def required_files?
  cert_vault && private_key
end

def cert_vault
  cert_id = Digest::SHA256.new.update(new_resource.name).to_s
  @cert_vault ||= begin
                    chef_vault_item('certificates', "#{cert_id}")
                  rescue => e
                    Chef::Log.error("Could not find any certs in the vault. \
                                    The ID of the cert was #{cert_id}, \
                                    which should correspond to #{node['fqdn']}.\
                                    (#{e})")
                    {}
                  end
end

def stale_csr?
  !@cert_vault.empty? && node.attribute?('csr_outbox')
end

def private_key
  @private_key ||= begin
                     chef_vault_item('private_keys', "#{node['fqdn']}")
                   rescue => e
                     Chef::Log.error("Couldn't load private key. (#{e})")
                     nil
                   end
end
