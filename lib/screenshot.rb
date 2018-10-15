class Screenshot
  def self.update_all
    Document.all.each do |document|
      update(document: document, replace: true)
    end
  end

  def self.update_new
    Document.all.each do |document|
      update(document: document, replace: false)
    end
  end

  def self.update(document:, replace: false)
    source = document.read

    source.gsub!(/```screenshot(.+?)```/m) do |s|
      config = YAML.safe_load($1)
      next s if config['image'].present? && !replace

      execute(config: config)
    end

    File.write(document.path, source)
  end

  def self.execute(config:)
    output = `node #{config['script']}`.strip
    config['image'] = output if output.start_with? 'public/assets/screenshots/'

    output = <<~HEREDOC
      ```screenshot
      #{config.to_yaml.gsub("---\n", '').strip}
      ```
    HEREDOC

    output.strip
  end
end
