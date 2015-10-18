# require 'digest/sha2'

# include SSLCertsCookbook::Helpers

# use_inline_resources

# def whyrun_supported?
#   true
# end

# action :create do
#   converge_by("Create a Certificate #{@new_resource}") do
#     cert_vault = begin
#                    data_bag_item('certificates', "#{cert_id}")
#                  rescue => e
#                    Chef::Log.error(<<-EOERR
# Could not find any certs in the vault.  The ID of the cert was #{cert_id},
# which should correspond to #{node['fqdn']}. (#{e})
# EOERR
#                                   )
#                    {}
#                  end
#     if cert_vault && private_key
#       file new_resource.name do
#         owner new_resource.owner
#         group new_resource.group
#         mode '0644'
#         action :create
#         content cert_vault['certificate']
#       end
#     else
#       Chef::Log.warn('I don\'t have the required files to continue!')
#       Chef::Log.warn("Private Key: #{private_key}")
#       Chef::Log.warn("Cert Vault: #{cert_vault}")
#     end

#     if node.set['csr_outbox'].delete(node['fqdn'])
#       new_resource.updated_by_last_action true
#     end
#   end
# end

# protected

# def cert_id
#   @cert_id ||= Digest::SHA256.new.update(node['fqdn']).to_s
# end

# def private_key
#   @private_key ||= begin
#                      ::File.read(::File.expand_path(new_resource.private_key))
#                    rescue => e
#                      Chef::Log.error("Couldn't load private key. (#{e})")
#                      nil
#                    end
# end
