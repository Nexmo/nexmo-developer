class TutorialsFilter < Banzai::Filter
  def call(input)
    input.gsub(/```tutorials(.+?)```/m) do |_s|
      config = YAML.safe_load($1)
      @product = config['product']
      @tutorials = Tutorial.by_product(@product)
      erb = File.read("#{Rails.root}/app/views/tutorials/_index.html.erb")
      html = ERB.new(erb).result(binding)
      "FREEZESTART#{Base64.urlsafe_encode64(html)}FREEZEEND"
    end
  end
end
