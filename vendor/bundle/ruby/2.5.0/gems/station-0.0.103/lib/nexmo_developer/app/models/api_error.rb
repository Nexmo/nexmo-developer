class ApiError
  include ActiveModel::Model
  attr_accessor :id, :description, :resolution, :link_url
  attr_writer :link_text

  def link_text
    @link_text || 'Find out more'
  end

  def link=(link)
    @link_text = link['text']
    @link_url = link['url']
  end

  def link
    return nil unless @link_text && @link_url

    OpenStruct.new({
      text: @link_text,
      url: @link_url,
    })
  end

  def self.parse_config(errors)
    return [] if errors.blank?

    errors.map do |id, config|
      ApiError.new({ id: id }.merge(config))
    end
  end
end
