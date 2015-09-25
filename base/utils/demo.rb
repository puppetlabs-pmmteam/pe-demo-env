require 'vagrant'
require File.join File.dirname(__FILE__), 'demo', 'plugin'
require File.join File.dirname(__FILE__), 'demo', 'helpers'
require File.join File.dirname(__FILE__), 'config_builder_overrides'
require File.join File.dirname(__FILE__), 'oscar_overrides'

module Demo

  extend  Demo::Helpers
  include Demo::Helpers

  def load_directories(demo)
    directories = Array.new

    if demo.key?('inherits')
      directories << load_directories(demos[demo['inherits']])
    end

    demo_directory = File.join(vagrantdir, demo['directory'])
    directories << demo_directory

    directories
  end

  def vagrantdir
    File.join(File.dirname(__FILE__), '..', '..')
  end

  def demo_directories
    Demo::loaded_demos.map do |demo|
      load_directories demo
    end.flatten.uniq
  end

  def self.loaded_demos
    saved_demos = IO.read(File.join(vagrantdir, '.demo')).split
    demo_list = Array.new

    saved_demos.each do |saved_demo|
      demo_list << demos[saved_demo]
    end

    demo_list
  end
end