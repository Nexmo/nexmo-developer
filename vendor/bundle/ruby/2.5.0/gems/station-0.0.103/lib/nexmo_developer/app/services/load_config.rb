class LoadConfig
  def self.docs_base_path
    Rails.configuration.docs_base_path || '.'
  end

  def self.load_file(file_path)
    full_path = "#{docs_base_path}/#{file_path}"
    if File.exist?(full_path)
      YAML.load_file(full_path)
    else
      YAML.load_file("#{Rails.root}/#{file_path}")
    end
  end
end
