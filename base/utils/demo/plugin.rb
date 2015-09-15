require 'vagrant'

module Demo
  class Plugin < Vagrant.plugin('2')
    name 'demo'

    command(:demo) do
      require_relative "command"
      Demo::Command
    end
  end
end
