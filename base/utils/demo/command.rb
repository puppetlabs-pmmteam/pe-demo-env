module Demo
  class Command < Vagrant.plugin(2, :command)

    Dir[File.join File.dirname(__FILE__), 'command', '*'].each do |lib|
      require lib
    end

    include Demo::Helpers

    def initialize(argv, env)
      @argv     = argv
      @env      = env
      @cmd_name = 'demo'

      split_argv
      register_subcommands
    end

    def execute
      invoke_subcommand
    end

    private

    def register_subcommands
      @subcommands = Vagrant::Registry.new

      @subcommands.register('list') do
        Demo::Command::List
      end

      @subcommands.register('show') do
        Demo::Command::Show
      end

      @subcommands.register('use') do
        Demo::Command::Use
      end
    end
  end
end
