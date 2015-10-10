property :ca_dir, String, default: '/etc/pki/CA/'
property :key_file, String, default: 'private/auth-intermediate.key.pem'
property :cert_file, String, default: 'certs/auth-intermediate.cert.pem'
property :serial_file, String, default: 'serial'
property :password, String, required: true
property :vault, String, default: 'ca'
property :vault_admins, [Array, String]

action :load do
  ca_vault = load_ca_vault
  unless ca_vault[node['fqdn']] || !ca_files_exist?
    chef_vault_secret node['fqdn'] do
      admins vault_admins
      data_bag vault
      raw_data(cacert: ::File.read(cert_file),
               pkey: ::File.read(key_file),
               serial: ::File.read(serial_file),
               password: password)
      search "fqdn:#{node['fqdn']}"
    end
  end
end

protected

def load_ca_vault
  data_bag(vault)
rescue => e
  Chef::Log.warn("Vault #{vault} not found. (#{e}) Trying to create it.")
  create_bag(vault)
end

def ca_files_exist?
  key, cert, serial = [key_file, cert_file, serial_file].map { |f| ca_dir + f }
  ::File.exist?(key) && ::File.exist?(cert) && ::File.exist?(serial)
end

private

def create_bag(bag_name)
  ruby_block "create-data_bag-#{bag_name}" do
    block do
      Chef::DataBag.validate_name!(bag_name)
      Chef::DataBag.new.name(bag_name).save
    end
    action :create
  end
  data_bag(bag_name)
end
