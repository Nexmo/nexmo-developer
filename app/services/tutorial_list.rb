class TutorialList
  def self.by_product(product)
    {
      'tutorials' => tasks_for_product(product),

      'use_cases' => UseCase.by_product(product).map do |t|
                       {
                         path: t.document_path,
                         title: t.title,
                         product: product,
                         is_file?: true,
                         is_tutorial?: true,
                       }
                     end,
    }
  end

  def self.tasks_for_product(product)
    tasks = {}
    Dir.glob("#{Rails.root}/config/tasks/*.yml") do |filename|
      t = YAML.load_file(filename)
      tasks[t['product']] = [] unless tasks[t['product']]
      tasks[t['product']].push({
                                 path: filename,
                                 title: t['title'],
                                 product: product,
                                 is_file?: true,
                                 is_task?: true,
                               })
    end

    tasks[product]
  end
end
