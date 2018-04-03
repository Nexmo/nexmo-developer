class ApiError
  include ActiveModel::Model
  attr_accessor :id, :description, :resolution, :link_url
  attr_writer :link_text

  def link_text
    @link_text || 'Find out more'
  end
end
