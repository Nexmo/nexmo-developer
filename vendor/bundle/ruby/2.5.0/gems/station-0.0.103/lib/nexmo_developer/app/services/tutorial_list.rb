class TutorialList
  def self.by_product(product)
    {
      'tutorials' => tasks_for_product(product),

      'use_cases' => Nexmo::Markdown::UseCase.by_product(product).map do |t|
                       {
                         root: t.root,
                         path: t.document_path.to_s,
                         title: t.title,
                         product: product,
                         is_file?: true,
                         is_tutorial?: true,
                       }
                     end,
    }
  end

  def self.tasks_for_product(product)
    tasks = Hash.new { |h, k| h[k] = [] }
    all.each do |t|
      t.products.each do |p|
        t.product = p
        tasks[p].push(t)
      end
    end

    tasks[product]
  end

  def self.all
    tasks = []
    # TODO: make this work with I18n fallback
    Dir.glob("#{Rails.configuration.docs_base_path}/config/tutorials/#{I18n.default_locale}/*.yml") do |path|
      tasks.push(TutorialListItem.new(path))
    end
    tasks
  end
end
