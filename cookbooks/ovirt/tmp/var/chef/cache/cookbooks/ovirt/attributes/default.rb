default['ovirt'] = {
  'application_mode' => 'both',
  'storage_type' => 'nfs',
  'organization' => 'localdomain',
  'nfs_config_enabled' => true,
  'iso_domain_name' => 'ISO_DOMAIN',
  'iso_domain_mount_point' => '/var/lib/exports/iso',
  'admin_password' => 'admin',
  'db_user' => 'engine',
  'db_password' => 'dbpassword',
  'db_host' => 'localhost',
  'db_port' => '5432',
  'answers_file' => '/var/lib/ovirt-engine/setup/answers/answers-from-chef',
  'ovirt_release_base_url' => 'http://ovirt.org/releases',
  'supported_platforms' => %w(centos redhat),
  'firewall_manager' => 'firewalld',
  'ovirt_release_rpm' => 'ovirt-release-el.noarch.rpm'
}

default['ovirt']['ovirt_release_rpm_url'] =
  "#{node['ovirt']['ovirt_release_base_url']}/#{node['ovirt']['ovirt_release_rpm']}"
