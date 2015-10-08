file 'any potential existing request' do
  path '/etc/ssl_test/myreq.csr'
  action :delete
end

file 'any potential existing private key' do
  path '/etc/ssl_test/myreq.key'
  action :delete
end

# Create directory if not already present
directory '/etc/ssl_test' do
  recursive true
end

# generate a new request
sslcerts_signing_req '/etc/ssl_test/myreq.csr' do
  common_name 'myreq.example.com'
  org 'Test Kitchen Example'
  org_unit 'Kitchens'
  country 'UK'
end
