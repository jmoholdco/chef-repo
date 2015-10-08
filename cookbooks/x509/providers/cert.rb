require 'digest/sha2'

action :create do
  [new_resource.cert, new_resource.ca_cert].each do |cert_file|
    file cert_file do
      owner new_resource.owner
      group new_resource.group
      mode 0644
      action :nothing
    end
  end
  file new_resource.key do
    owner new_resource.owner
    group new_resource.group
    mode 0600
    action :nothing
  end

  name_sha = Digest::SHA256.new << new_resource.name
  cert_id = name_sha.to_s
end
