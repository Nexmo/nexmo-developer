class Repo
  attr_accessor :path
  attr_writer :branch, :protocol, :namespace, :host, :url, :repo

  def initialize(params)
    params.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end

  def branch
    @branch || 'master'
  end

  def protocol
    @protocol || 'git'
  end

  def namespace
    return @namespace if @namespace
    return @repo if @repo
    raise 'You must provide github or url' unless @url
    extract_namespace_from_url
  end

  def repo
    @repo || @repo
  end

  def host
    @host || 'github.com'
  end

  def url
    return @url if @url
    case protocol
    when 'git' then "git://#{host}/#{repo}.git"
    when 'https' then "https://#{host}/#{repo}.git"
    when 'ssh' then "git@#{host}:#{repo}.git"
    end
  end

  def directory
    "#{Rails.root}/.repos/#{namespace}"
  end

  def self.valid_url?(string)
    ['git://', 'git@', 'https://'].any? { |protocol| string.start_with?(protocol) }
  end

  private

  def extract_namespace_from_url
    @url.match(%r{^(?:(?:git|https)://|git@).+?(?:/|:)(.+?).git})[1]
  rescue NoMethodError
    raise "Could not understand URL #{@url}"
  end
end
