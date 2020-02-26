class DynamicContentFilter < Banzai::Filter
  def call(input)
    input.gsub(/(\s|^)\[\~(.+?)\~\](\s|$)/) do
      content = environment_value($2) || config_value($2) || "VALUE NOT SET: #{$2}"
      "#{$1}#{content}#{$3}"
    end
  end

  private

  def environment_value(key)
    return nil unless ENV['DYNAMIC_CONTENT']

    @environment_dynamic_content ||= YAML.safe_load(ENV['DYNAMIC_CONTENT'])
    @environment_dynamic_content ||= YAML.safe_load(temp)
    @environment_dynamic_content[key]
  end

  def config_value(key)
    @config_dynamic_content ||= YAML.load_file("#{Rails.root}/config/dynamic_content.yml")
    @config_dynamic_content[key]
  end
end
