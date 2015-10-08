default['jml-ubuntu-defaults'] = {
  'shell' => '/bin/zsh',
  'admin_user' => {
    'user' => 'local',
    'group' => 'local',
    'shell' => '/bin/zsh',
    'sudo_group' => platform_family?('rhel') ? 'wheel' : 'sudo'
  },
  'zsh' => {
    'plugins' => %w(git)
  }
}

default['vim']['install_method'] = 'source'

default['vim']['source']['checksum'] =
  'd0f5a6d2c439f02d97fa21bd9121f4c5abb1f6cd8b5a79d3ca82867495734ade'

if platform_family? 'rhel'
  default['jml-ubuntu-defaults']['zsh']['plugins'] = %w(git yum systemd)
elsif platform_family? 'debian'
  default['jml-ubuntu-defaults']['zsh']['plugins'] = %w(git apt)
end

default['ovirt_guest'] = true
