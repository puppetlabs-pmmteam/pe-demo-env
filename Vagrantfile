# -*- mode: ruby -*-
# vi: set ft=ruby :

case Vagrant::VERSION
when /^1\.[1-4]/
  Vagrant.require_plugin('oscar')
else
  # The require_plugin call is deprecated in 1.5.x. Replacement? Dunno.
end

def demos
  demo_list = ['base']
  demo_list = String(ENV['demo']).split(',')
  $demos = demo_list.flatten
end

def vagrantdir
  File.dirname(__FILE__)
end

def demodirs 
  configdirs = Array.new
  configdirs << File.expand_path('base', vagrantdir)

  demos.each do |demo|
    configdirs << File.expand_path(demo, vagrantdir)
  end

  configdirs
end

if defined? Oscar
  require File.join(vagrantdir, 'base', 'utils', 'config_builder_overrides')
  require File.join(vagrantdir, 'base', 'utils', 'oscar_overrides')

  class ReloadPluginSupport < ::ConfigBuilder::Model::Base
    def to_proc
      Proc.new do |vm_config|
        vm_config.provision :reload
      end
    end
 
    ::ConfigBuilder::Model::Provisioner.register('reload', self)
  end
  
  Vagrant.configure('2', &Oscar.run(demodirs))
end
