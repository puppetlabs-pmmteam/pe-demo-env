require 'pp'
require 'json'

module Demo
  class Command::List < Vagrant.plugin('2', :command)

    include Demo::Command::Helpers

    def initialize(argv, env)
      @argv     = argv
      @env      = env
      @cmd_name = 'demo list'

      @provider = nil

      split_argv
    end

    def execute
      argv = parse_options(parser)
      print_current_demo

      puts "Available Demos:"
      puts demos.keys.map { |k| "* #{k}\n" }
    end

    private

    def parser
      OptionParser.new do |o|
        o.banner = "Usage: vagrant #{@cmd_name} [<args>]"
        o.separator ''

        o.on('-h', '--help', 'Display this help message') do
          puts o
          exit 0
        end
      end
    end
  end
end
