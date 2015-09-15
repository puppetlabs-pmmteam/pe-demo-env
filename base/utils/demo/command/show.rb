require 'pp'
require 'json'

module Demo
  class Command::Show< Vagrant.plugin('2', :command)

    include Demo::Command::Helpers

    def initialize(argv, env)
      @argv     = argv
      @env      = env
      @cmd_name = 'demo show'

      @provider = nil

      split_argv
    end

    def execute
      argv = parse_options(parser)
      demo = argv.last

      print_current_demo

      unless argv.size == 2
        puts "Usage: vagrant #{@cmd_name} [demo name]"
        exit 1
      end

      ensure_demos_exist(demo)

      metadata = demos[demo]

      description = metadata['description'] || String.new
      info_url    = metadata['info_url']    || String.new
      parent_demo = metadata['parent_demo'] || 'base'


      puts demo.capitalize
      puts '  ' + info_url unless info_url.empty?
      puts '  ' + description unless description.empty?
    end

    private

    def parser
      OptionParser.new do |o|
        o.banner = "Usage: vagrant #{@cmd_name} [demo name]"
        o.separator ''

        o.on('-h', '--help', 'Display this help message') do
          puts o
          exit 0
        end
      end
    end
  end
end
