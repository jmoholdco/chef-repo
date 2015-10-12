default['nzbget']['source'] = {
  'release' => 'stable',
  'configuration' => '--with-libxml2-includes=/usr/include/libxml2 \
                      --with-libxml2-libraries=/usr/lib/x86_64-linux-gnu/libxml2.so',
  'checksum' => 'e2778d33633fade7bdaaccde500765eacea4197c82a3e808904539309d81b020',
  'dependencies' => %w(libxml2-dev libssl-dev libncurses5-dev build-essential),
  'additional_options' => {}   # i.e. github branch/ref/whatever
}
