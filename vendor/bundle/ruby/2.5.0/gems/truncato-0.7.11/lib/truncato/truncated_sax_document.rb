require 'nokogiri'
require 'htmlentities'

class TruncatedSaxDocument < Nokogiri::XML::SAX::Document
  IGNORABLE_TAGS = %w(html head body)

  SINGLE_TAGS = %w{br img}

  attr_reader :truncated_string, :max_length, :max_length_reached, :tail,
              :count_tags, :filtered_attributes, :filtered_tags, :ignored_levels

  def initialize(options)
    @html_coder = HTMLEntities.new
    capture_options options
    init_parsing_state
  end

  def start_element name, attributes
    enter_ignored_level if filtered_tags.include?(name)
    return if @max_length_reached || ignorable_tag?(name) || ignore_mode?
    @closing_tags.push name unless single_tag_element? name
    append_to_truncated_string opening_tag(name, attributes), overriden_tag_length
  end

  def characters decoded_string
    return if @max_length_reached || ignore_mode?
    remaining_length = max_length - @estimated_length - 1
    string_to_append = decoded_string.length > remaining_length ? truncate_string(decoded_string, remaining_length) : decoded_string
    append_to_truncated_string @html_coder.encode(string_to_append), string_to_append.length
  end

  def comment string
    if @comments
      return if @max_length_reached
      process_comment string
    end
  end

  def end_element name
    if filtered_tags.include?(name) && ignore_mode?
      exit_ignored_level
      return
    end

    return if @max_length_reached || ignorable_tag?(name) || ignore_mode?

    unless single_tag_element? name
      @closing_tags.pop
      append_to_truncated_string closing_tag(name), overriden_tag_length
    end
  end

  def end_document
    close_truncated_document if max_length_reached
  end

  private

  def capture_options(options)
    @max_length = options[:max_length]
    @count_tags = options [:count_tags]
    @count_tail = options.fetch(:count_tail, false)
    @tail = options[:tail]
    @filtered_attributes = options[:filtered_attributes] || []
    @filtered_tags = options[:filtered_tags] || []
    @tail_before_final_tag = options.fetch(:tail_before_final_tag, false)
    @comments = options.fetch(:comments, false)
  end

  def process_comment(string)
    remaining_length = max_length - @estimated_length - 1
    string_to_append = comment_tag(string).length > remaining_length ? truncate_comment(comment_tag(string), remaining_length) : comment_tag(string)
    append_to_truncated_string string_to_append
  end

  def comment_tag comment
    "<!--#{comment}-->"
  end

  def init_parsing_state
    @truncated_string = ""
    @closing_tags = []
    @estimated_length = @count_tail ? tail_length : 0
    @max_length_reached = false
    @ignored_levels = 0
  end

  def tail_length
    tail.match(/^&\w+;$/).nil? ? tail.length : 1
  end

  def single_tag_element? name
    SINGLE_TAGS.include? name
  end

  def append_to_truncated_string string, overriden_length=nil
    @truncated_string << string
    increase_estimated_length(overriden_length || string.length)
  end

  def opening_tag name, attributes
    attributes_string = attributes_to_string attributes
    if single_tag_element? name
      "<#{name}#{attributes_string}/>"
    else
      "<#{name}#{attributes_string}>"
    end
  end

  def attributes_to_string attributes
    return "" if attributes.empty?
    attributes_string = concatenate_attributes_declaration attributes
    attributes_string.rstrip
  end

  def concatenate_attributes_declaration attributes
    attributes.inject(' ') do |string, attribute|
      key, value = attribute
      next string if @filtered_attributes.include? key
      string << "#{key}='#{@html_coder.encode value}' "
    end
  end

  def closing_tag name
    "</#{name}>"
  end

  def increase_estimated_length amount
    @estimated_length += amount
    check_max_length_reached
  end

  def check_max_length_reached
    @max_length_reached = true if @estimated_length >= max_length
  end

  def truncate_string string, remaining_length
    if @tail_before_final_tag
      string[0..remaining_length]
    else
      @tail_appended = true
      "#{string[0..remaining_length]}#{tail}"
    end
  end

  def truncate_comment string, remaining_length
    if @tail_before_final_tag
      string[0..remaining_length]
    else
      @tail_appended = true
      "#{string[0..remaining_length]}#{tail}-->"
    end
  end

  def close_truncated_document
    append_tail_between_closing_tags if @tail_before_final_tag
    append_to_truncated_string tail unless @tail_appended
    append_closing_tags
  end

  def append_closing_tags
    @closing_tags.reverse.each { |name| append_to_truncated_string closing_tag name }
  end

  def overriden_tag_length
    @count_tags ? nil : 0
  end


  def ignorable_tag?(name)
    artificial_root_name?(name) || IGNORABLE_TAGS.include?(name.downcase)
  end

  def artificial_root_name? name
    name == Truncato::ARTIFICIAL_ROOT_NAME
  end

  def append_tail_between_closing_tags
    append_to_truncated_string closing_tag(@closing_tags.delete_at (@closing_tags.length - 1)) if @closing_tags.length > 1
  end

  def enter_ignored_level
    @ignored_levels += 1
  end

  def exit_ignored_level
    @ignored_levels -= 1
  end

  def ignore_mode?
    @ignored_levels > 0
  end
end
