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
    tasks = Hash.new { |h, k| h[k] = [] }
    all.each do |t|
      t[:products].each do |p|
        tasks[p].push(t.merge({ product: p }))
      end
    end

    tasks[product]
  end

  def self.all
    tasks = []
    Dir.glob("#{Rails.root}/config/tutorials/*.yml") do |filename|
      t = YAML.load_file(filename)
      tasks.push({
                   path: filename,
                   external_link: t['external_link'],
                   title: t['title'],
                   description: t['description'],
                   products: t['products'],
                   is_file?: true,
                   is_task?: true,
                 })
    end

    tasks
  end
end
