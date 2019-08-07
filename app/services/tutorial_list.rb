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
    Dir.glob("#{Rails.root}/config/tasks/*.yml") do |filename|
      t = YAML.load_file(filename)
      t['products'].each do |p|
        tasks[p].push({
                                   path: filename,
                                   external_link: t['external_link'],
                                   title: t['title'],
                                   product: p,
                                   is_file?: true,
                                   is_task?: true,
                                 })
      end
    end

    tasks[product]
  end
end
