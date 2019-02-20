require 'terminal-table'

namespace :links do
  desc 'Generate a report of all links FROM a given page'
  task 'report_outbound': :environment do
    ARGV.each { |a| task a.to_sym }
    filter = ARGV[1]
    table = Terminal::Table.new do |t|
      get_links_on_a_page("#{Rails.root}/_documentation/**/*.md").each do |from, to|
        next if filter && !from.include?(filter)
        t << [from.split(%r{(.{25,1000}/)}).join("\n").strip, to.join("\n")]
        t << :separator
      end
    end
    table.headings = ['From', 'To']
    puts table
  end

  desc 'Generate a report of all links TO a given page'
  task 'report_inbound': :environment do
    ARGV.each { |a| task a.to_sym }
    filter = ARGV[1]
    table = Terminal::Table.new do |t|
      get_links_to_a_page("#{Rails.root}/_documentation/**/*.md").each do |to, from|
        next if filter && !to.include?(filter)
        t << [to, from.join("\n")]
        t << :separator
      end
    end
    table.headings = ['To', 'From']
    puts table
  end

  desc 'Show all pages with no outbound links'
  task 'no_links_outbound': :environment do
    get_links_on_a_page("#{Rails.root}/_documentation/**/*.md").each do |from, to|
      puts from if to.empty?
    end
  end

  desc 'Show all pages with no inbound links'
  task 'no_links_inbound': :environment do
    get_links_to_a_page("#{Rails.root}/_documentation/**/*.md").each do |to, from|
      puts to if from.empty?
    end
  end

  desc 'Generate graph of all links out of pages'
  task 'graph_outbound': :environment do
    ARGV.each { |a| task a.to_sym }
    filter = ARGV[1]
    additional_title = ''
    additional_title = "containing '#{filter}'" if filter
    puts 'digraph {'
    get_links_on_a_page("#{Rails.root}/_documentation/**/*.md").each do |from, to|
      next if filter && !from.include?(filter)
      to.each do |l|
        puts "\"#{from}\" -> \"#{l}\""
      end
    end
    puts <<~HEREDOC
      labelloc="t";
      label="Links FROM pages #{additional_title}";
    HEREDOC
    puts '}'
  end

  desc 'Generate graph of all links to pages'
  task 'graph_inbound': :environment do
    ARGV.each { |a| task a.to_sym }
    filter = ARGV[1]
    additional_title = ''
    additional_title = "containing '#{filter}'" if filter
    puts 'digraph {'
    get_links_to_a_page("#{Rails.root}/_documentation/**/*.md").each do |to, from|
      next if filter && !to.include?(filter)
      from.each do |l|
        puts "\"#{l}\" -> \"#{to}\""
      end
    end
    puts <<~HEREDOC
      labelloc="t";
      label="Links TO pages #{additional_title}";
    HEREDOC
    puts '}'
  end
end

def get_links_on_a_page(path)
  all_links = {}
  get_all_links(path) do |current_page, links|
    all_links[current_page] = links
  end

  all_links
end

def get_links_to_a_page(path)
  all_links = {}
  get_all_links(path) do |current_page, links|
    links.each do |l|
      all_links[l] ||= []
      all_links[l].push(current_page)
    end
  end

  all_links
end

def get_all_links(path)
  Dir.glob(path).first(10000).each do |filename|
    # Generate the resultant HTML
    document = File.read(filename)
    output = MarkdownPipeline.new.call(document)

    # Get our current URL
    current_page = filename.gsub("#{Rails.root}/_documentation", '').gsub(/\.md$/, '')
    # Load all links on the page
    links = get_links_from_html(output)

    yield(current_page, links)
  end
end

def get_links_from_html(html)
  Nokogiri::HTML(html).css('a')
          .map { |link| link.attr('href') }
          .compact
          .reject { |link| link.start_with?('#', 'http', 'mailto:') }
          .uniq
end
