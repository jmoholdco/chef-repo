file 'Any potential existing cert' do
  path '/etc/ssl_test/mycert.crt'
  action :delete
end

file 'Any potential existing key' do
  path '/etc/ssl_test/mycert.key'
  action :delete
end

file 'Any potential existing second cert' do
  path '/etc/ssl_test/mycert2.crt'
  action :delete
end

# Create directory if not already present
directory '/etc/ssl_test' do
  recursive true
end

# Generate new key and certificate
sslcerts_x509 '/etc/ssl_test/mycert.crt' do
  common_name 'mycert.example.com'
  org 'Test Kitchen Example'
  org_unit 'Kitchens'
  country 'UK'
end

# Generate a new certificate from an existing key
sslcerts_x509 '/etc/ssl_test/mycert2.crt' do
  common_name 'mycert2.example.com'
  org 'Test Kitchen Example'
  org_unit 'Kitchens'
  country 'UK'
  key_file '/etc/ssl_test/mycert.key'
end
