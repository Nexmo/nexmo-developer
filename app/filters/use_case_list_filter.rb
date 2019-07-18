class UseCaseListFilter < Banzai::Filter
  def call(input)
    input.gsub(/```use_cases(.+?)```/m) do |_s|
      config = YAML.safe_load($1)
      @product = config['product']
      @tutorials = UseCase.by_product(@product)

      # Default to plain layout, but allow people to override it
      config['layout'] = 'list/plain' unless config['layout']

      erb = File.read("#{Rails.root}/app/views/use_case/#{config['layout']}.html.erb")
      html = ERB.new(erb).result(binding)
      "FREEZESTART#{Base64.urlsafe_encode64(html)}FREEZEEND"
    end
  end
end
