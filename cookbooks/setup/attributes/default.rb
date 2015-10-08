default['chef_client']['load_gems'] = {
  'chef_handler_foreman' => {
    'require_name' => 'chef_handler_foreman',
    'version' => '0.1'
  }
}

default['chef_client']['init_style'] = 'init'
default['setup']['client']['foreman_host'] = 'https://foreman.jmorgan.org:8443'
default['chef_client']['interval'] = 900

default['setup']['client']['enabled'] = true
