default['jml-ubuntu-defaults']['dotfiles'] = {
  'include_root' => true,
  'repo' => 'https://github.com/baberthal/dotfiles.git',
  'shell' => '/bin/zsh'
}

node_attr = node['jml-ubuntu-defaults']

default['jml-ubuntu-defaults']['dotfiles']['users'] = if node_attr['admin_user']
                                                        node_attr['admin_user']['user']
                                                      else
                                                        []
                                                      end
