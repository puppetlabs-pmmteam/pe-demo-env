require 'yaml'

module Demo::Command::Helpers

  private

  def split_argv
    @main_args, @subcommand, @sub_args = split_main_and_subcommand(@argv)
  end

  def parse_demos(argv)
    argv.last.split(',')
  end

  def print_current_demo
    puts "Current loaded demos: #{current_demos.join(',')}\n\n"
  end

  def ensure_demos_exist(passed_demos)
    passed_demos = Array(passed_demos)
    missing_demos = Array.new

    passed_demos.each do |demo|
      missing_demos << demo unless demos.key?(demo)
    end

    if missing_demos.size > 0
      puts "Err: The following demos don't exist. Run `vagrant demo list` to see available demos"
      puts missing_demos
      exit 1
    end
  end

  def current_demos
    demo_file = File.join(project_root, '.demo')

    if File.exists? demo_file
      IO.read(demo_file).split
    else
      ['base']
    end
  end

  def demos
    return @demos if @demos

    @demos = Hash.new

    demo_config_files.each do |demo|
      demo_config = YAML::load(IO.read(demo))['demo']
      @demos.merge! demo_config
    end

    @demos
  end

  def demo_config_files
    demo_search_path = File.join(project_root, '**', 'demo.yaml')
    Dir[demo_search_path]
  end

  def project_root
    return @project_root if @project_root

    cur_path = File.dirname(__FILE__).split(File::SEPARATOR)
    count = cur_path.size
    count.times do
      path = cur_path
      vagrantfile = File.join(path, 'Vagrantfile')
      if File.exists?(vagrantfile)
        @project_root = path
        break
      else
        cur_path.pop
      end
    end

    @project_root
  end

  def invoke_subcommand
    if @subcommand and (klass = @subcommands.get(@subcommand))
      klass.new(@argv, @env).execute
    elsif @subcommand
      @env.ui.error "Unrecognized subcommand: #{@subcommand}"
      print_subcommand_help(:error)
    else
      print_subcommand_help
    end
  end

  def print_subcommand_help(output = :info)
    msg = []
    msg << "Usage: vagrant #{@cmd_name} <command> [<args>]"
    msg << ''
    msg << 'Available subcommands:'

    keys = []
    @subcommands.each { |(key, _)| keys << key }
    msg += keys.sort.map { |key| "     #{key}" }

    msg << ''
    msg << "For help on any individual command run `vagrant #{@cmd_name} <command> -h`"

    @env.ui.send(output, msg.join("\n"))
  end
end
