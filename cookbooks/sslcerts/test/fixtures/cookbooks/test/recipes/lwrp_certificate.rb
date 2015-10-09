include_recipe 'chef-vault'

file 'any potential existing cert' do
  path '/etc/ssl_test/mysignedcert.pem'
  action :delete
end

directory '/etc/ssl_test' do
  recursive true
end

sslcerts_certificate '/etc/ssl_test/mysignedcert.pem' do
  action :create
end
