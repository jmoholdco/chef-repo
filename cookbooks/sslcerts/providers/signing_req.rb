# include SSLCertsCookbook::Helpers

# use_inline_resources

# def whyrun_supported?
#   true
# end

# attr_reader :key_file, :key, :cert

# action :create do
#   cert_id = Digest::SHA256.new.update(node['fqdn'])
#   if !node.attribute?('csr_outbox') || !node['csr_outbox'][node['fqdn']]
#     converge_by("Create #{@new_resource}") do
#       key_content = key.to_pem
#       csr_content = csr.to_pem

#       node.set['csr_outbox'][node['fqdn']] = {
#         id: cert_id,
#         csr: csr_content,
#         date: Time.now.to_s
#       }

#       file new_resource.name do
#         action :create_if_missing
#         mode new_resource.mode
#         owner new_resource.owner
#         group new_resource.group
#         sensitive true
#         content csr_content
#       end

#       file new_resource.key_file do
#         action :create_if_missing
#         mode new_resource.mode
#         owner new_resource.owner
#         group new_resource.group
#         sensitive true
#         content key_content
#       end
#       new_resource.updated_by_last_action true
#     end
#   else
#     Chef::Log.debug("#{new_resource} already exists. Nothing to do.")
#   end
# end

# protected

# def cert_dir
# end

# def key_file
#   return new_resource.key_file if new_resource.key_file
#   file = ::File.basename(new_resource.name, ::File.extname(new_resource.name))
#   new_resource.key_file "#{cert_dir}/private/#{file}.key"
# end

# def key
#   @key ||= resource_key(key_file, new_resource)
# end

# def csr
#   @csr ||= resource_csr(key, subject)
# end

# def subject
#   @subject ||= resource_subject(new_resource)
# end
