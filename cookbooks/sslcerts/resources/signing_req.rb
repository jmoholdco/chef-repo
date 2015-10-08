actions :create
default_action :create

attribute :name, kind_of: String, name_attribute: true
attribute :owner, kind_of: String
attribute :group, kind_of: String
attribute :mode, kind_of: [Integer, String]
attribute :org, kind_of: String, required: true
attribute :org_unit, kind_of: String
attribute :country, kind_of: String, required: true
attribute :state, kind_of: String
attribute :city, kind_of: String
attribute :common_name, kind_of: String, required: true
attribute :email, kind_of: String, default: nil
attribute :key_file, kind_of: String, default: nil
attribute :key_pass, kind_of: String, default: nil
attribute :bits, equal_to: [1024, 2048, 4096, 8192], default: 2048
