IGNORED_FORMATS = %w[php action swf].freeze

class NotFoundNotifier
  def self.notify(request, exception)
    return if ignored_format?(request.params['format'])
    return if crawler?(request.user_agent)

    Bugsnag.notify(notification_name(exception)) do |notification|
      notification.add_tab(:request, {
        params: request.params,
        path: request.path,
        base_url: request.base_url,
      })
    end
  end

  def self.ignored_format?(format)
    return false unless format

    IGNORED_FORMATS.include? format.downcase
  end

  def self.crawler?(user_agent)
    Woothee.parse(user_agent)[:category] == :crawler
  end

  def self.notification_name(exception)
    if exception.instance_of? Nexmo::Markdown::DocFinder::MissingDoc
      'Missing Document'
    else
      '404 - Not Found'
    end
  end
end
