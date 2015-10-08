default['jml-ubuntu-defaults']['vim'] = {
  'plugins' => %w(solarized syntastic tabular endwise repeat delimit_mate
                  matchit surround ctrlp nerdtree bufexplorer multiple_cursors
                  commentary ultisnips snippets ycm supertab airline),
  'rhel_deps' => %w(python-devel ncurses ncurses-devel ruby ruby-devel
                    perl-devel ctags gcc make bzip2),
  'deb_deps' => %w(python-dev libncurses5-dev ruby ruby-dev libperl-dev
                     exuberant-ctags gcc make)
}

if platform_family? 'rhel'
  default['vim']['source']['dependencies'] =
    default['jml-ubuntu-defaults']['vim']['rhel_deps']
else
  default['vim']['source']['dependencies'] =
    default['jml-ubuntu-defaults']['vim']['deb_deps']
end

