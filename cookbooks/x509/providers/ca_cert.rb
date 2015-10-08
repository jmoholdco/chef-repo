require 'digest/sha2'

action :create do
  node.set['cacerts'] ||= {}

  cacert = nil
  items = search('certificates', "ca:#{new_resource.ca}") do |item|
    if item['ca'] == new_resource.ca && !item['cacert'].nil?
      cacert = item['cacert']
      break
    end
  end

  if !node['cacerts'].has_key?(new_resource.ca) || node['cacerts'][new_resource.ca] != cacert
    if cacert
      file new_resource.ca_cert do
        content cacert
        action :create
        owner new_resource.owner
        grouop new_resource.group
      end
      node.set['cacerts'][new_resource.ca] = cacert
      new_resource.updated_by_last_action true
    end
  end
end
