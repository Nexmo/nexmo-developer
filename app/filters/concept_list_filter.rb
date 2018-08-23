class ConceptListFilter < Banzai::Filter
  def call(input)
    input.gsub(/```concept_list(.+?)```/m) do |_s|
      config = YAML.safe_load($1)
      @product = config['product']
      @concepts = Concept.by_product(@product)
      erb = File.read("#{Rails.root}/app/views/concepts/list/plain.html.erb")
      html = ERB.new(erb).result(binding)
      "FREEZESTART#{Base64.urlsafe_encode64(html)}FREEZEEND"
    end
  end
end
