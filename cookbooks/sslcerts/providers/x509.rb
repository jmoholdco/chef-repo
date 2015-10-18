# include SSLCertsCookbook::Helpers

# use_inline_resources

# def whyrun_supported?
#   true
# end

# attr_reader :key_file, :key, :cert, :csr

# action :create do
#   converge_by("Create #{@new_resource}") do
#     unless ::File.exist? new_resource.name
#       create_keys
#       cert_content = cert.to_pem
#       key_content = key.to_pem

#       file new_resource.name do
#         action :create_if_missing
#         mode new_resource.mode
#         owner new_resource.owner
#         group new_resource.group
#         sensitive true
#         content cert_content
#       end

#       file new_resource.key_file do
#         action :create_if_missing
#         mode new_resource.mode
#         owner new_resource.owner
#         group new_resource.group
#         sensitive true
#         content key_content
#       end
#       new_resource.updated_by_last_action(true)
#     end
#   end
# end

# protected

# def key_file
#   unless new_resource.key_file
#     path, file = ::File.split(new_resource.name)
#     filename = ::File.basename(file, ::File.extname(file))
#     new_resource.key_file path + '/' + filename + '.key'
#   end
#   new_resource.key_file
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

# def cert
#   @cert ||= SSLCertsCookbook::Utils::Certificate.new(csr: csr)
# end

# def create_keys
#   cert.sign key
# end
