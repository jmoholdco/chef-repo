default['public']['firewall']['enabled_services'] = %w(http/https ssh)
default['firewall']['allow_ssh'] = true

default['public']['firewalld']['services'] = %w(http https ssh)
default['public']['firewalld']['ports'] = nil
default['public']['firewalld']['default_zone'] = 'public'
