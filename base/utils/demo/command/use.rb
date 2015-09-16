require 'pp'
require 'json'

module Demo
  class Command::Use < Vagrant.plugin('2', :command)

    include Demo::Command::Helpers

    def initialize(argv, env)
      @argv     = argv
      @env      = env
      @cmd_name = 'demo use'

      @provider = nil

      split_argv
    end

    def execute
      argv = parse_options(parser)
      demos = parse_demos(argv)

      unless argv.size == 2
        puts "Usage: vagrant #{@cmd_name} [comma separate list of demos]"
        exit 1
      end

      ensure_demos_exist(demos)

      File.open(File.join(project_root, '.demo'), 'w') { |f| f.write demos.join("\n") }

      puts "You can now load #{demos.join(',')} with `vagrant up`"
    end

    private

    def parser
      OptionParser.new do |o|
        o.banner = "Usage: vagrant #{@cmd_name} [comma separated list of demos]"
        o.separator ''

        o.on('-h', '--help', 'Display this help message') do
          puts o
          exit 0
        end
      end
    end
  end
end
