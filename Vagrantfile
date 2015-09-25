# -*- mode: ruby -*-
# vi: set ft=ruby :

case Vagrant::VERSION
when /^1\.[1-4]/
  Vagrant.require_plugin('oscar')
else
  # The require_plugin call is deprecated in 1.5.x. Replacement? Dunno.
end

require File.join File.dirname(__FILE__), 'base', 'utils', 'demo'
include ::Demo

if defined? Oscar

  class ReloadPluginSupport < ::ConfigBuilder::Model::Base
    def to_proc
      Proc.new do |vm_config|
        vm_config.provision :reload
      end
    end
 
    ::ConfigBuilder::Model::Provisioner.register('reload', self)
  end
  
  Vagrant.configure('2', &Oscar.run(demo_directories))
end
