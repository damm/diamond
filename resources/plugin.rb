actions :enable, :disable
attribute :options, :kind_of => Hash
attribute :source, :kind_of => String
attribute :template, :kind_of => String
attribute :cookbook, :kind_of => String
attribute :collectors_path, :kind_of => String, :default => "/opt/diamond/etc/diamond/collectors"

def initialize(*args)
  super
  @action = :enable
end
