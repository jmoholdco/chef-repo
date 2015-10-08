class Chef
  class Recipe
    module JMLFirewallRules
      RULE_TABLE = {
        'default' => {
          protocol: :tcp,
          command: :allow
        },
        'http/https' => {
          port: [80, 443],
        },
        'ssh' => {
          port: 22,
        },
        'dhcp' => {
          protocol: :udp,
          port: [67, 68]
        },
        'tftp' => {
          protocol: :udp,
          port: 69
        },
        'puppet_master' => {
          protocol: :tcp,
          port: 8140
        },
        'smart_proxy' => {
          protocol: :tcp,
          port: 8443
        }
      }

      def self.lookup(query)
        RULE_TABLE['default'].merge(RULE_TABLE[query])
      end
    end

    def rule_lookup(service_name)
      rule = JMLFirewallRules.lookup(service_name)
      return rule unless service_name == 'dns'
      format_dns(rule)
    end
  end
end
