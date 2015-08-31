module Oscar
  def self.config_dir
    @@config_dir
  end

  def self.config_dir=(dir)
    @@config_dir = dir
  end

  module Runner
    def run(config_dir)
      Oscar.config_dir = config_dir
      ConfigBuilder.load(:yaml_erb, :yamldir, config_dir)
    end
  end
end
