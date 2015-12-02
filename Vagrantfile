# -*- mode: ruby -*-
# vi: set ft=ruby :

require File.join File.dirname(__FILE__), 'base', 'utils', 'demo'

include ::Demo

load_demo_utils

if defined? Oscar
  Vagrant.configure('2', &Oscar.run(demo_directories))
end
