actions :create
default_action :create

attribute :name, kind_of: String, name_attribute: true
attribute :owner, kind_of: String, default: 'root'
attribute :group, kind_of: String, default: 'root'

attribute :common_name, kind_of: String
attribute :type, equal_to: ['server', 'client']
attribute :bits, equal_to: [1024, 2048, 4096, 8192], default: 2048
attribute :days, kind_of: Fixnum, default: (365 * 5)
