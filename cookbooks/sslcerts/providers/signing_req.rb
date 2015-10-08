include SSLCertsCookbook::Helpers

use_inline_resources

def whyrun_supported?
  true
end

attr_reader :key_file, :key, :cert

action :create do
  converge_by("Create #{@new_resource}") do
    unless ::File.exist? new_resource.name
      key_content = key.to_pem
      csr_content = csr.to_pem

      node.set['csr_outbox'][csr_short_name] = csr_content

      file new_resource.name do
        action :create_if_missing
        mode new_resource.mode
        owner new_resource.owner
        group new_resource.group
        sensitive true
        content csr_content
      end

      file new_resource.key_file do
        action :create_if_missing
        mode new_resource.mode
        owner new_resource.owner
        group new_resource.group
        sensitive true
        content key_content
      end
      new_resource.updated_by_last_action true
    end
  end
end

protected

def csr_short_name
  _, file = ::File.split(new_resource.name)
  ::File.basename(file)
end

def key_file
  unless new_resource.key_file
    _, file = ::File.split(new_resource.name)
    filename = ::File.basename(file, ::File.extname(file))
    new_resource.key_file '/etc/pki/tls/private/' + filename + '.key'
  end
  new_resource.key_file
end

def key
  @key ||= resource_key(key_file, new_resource)
end

def csr
  @csr ||= resource_csr(key, subject)
end

def subject
  @subject ||= resource_subject(new_resource)
end
