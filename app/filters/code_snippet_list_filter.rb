class CodeSnippetListFilter < Banzai::Filter
  def call(input)
    input.gsub(/```code_snippet_list(.+?)```/m) do |_s|
      config = YAML.safe_load($1)
      @product = config['product']
      @blocks = CodeSnippet.by_product(@product)

      # Top level blocks come before subfolder
      @blocks.sort_by! do |b|
        sort_array = []
        sort_array << (b.category ? 1 : 0)
        sort_array << b.navigation_weight
        sort_array
      end

      erb = File.read("#{Rails.root}/app/views/code_snippets/list/plain.html.erb")
      html = ERB.new(erb).result(binding)
      "FREEZESTART#{Base64.urlsafe_encode64(html)}FREEZEEND"
    end
  end
end
