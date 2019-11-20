module ApplicationHelper
  def search_enabled?
    defined?(ALGOLIA_CONFIG) && ENV['ALGOLIA_SEARCH_KEY']
  end

  def theme
    return unless ENV['THEME']
    "theme--#{ENV['THEME']}"
  end

  def title
    if @product && @document_title
      "Nexmo Developer | #{@product.titleize} > #{@document_title}"
    elsif @document_title
      "Nexmo Developer | #{@document_title}"
    else
      'Nexmo Developer'
    end
  end

  def show_canonical_meta?
    return true if params[:code_language].present?
    return true if Rails.env.production? && request.base_url != 'https://developer.nexmo.com'
    false
  end

  def canonical_path
    request.path.chomp("/#{params[:code_language]}")
  end

  def canonical_url
    return @canonical_url if @canonical_url
    canonical_path.prepend(canonical_base)
  end

  def canonical_base
    Rails.env.production? ? 'https://developer.nexmo.com' : request.base_url
  end

  def dashboard_cookie(campaign)
    # This is the first touch time so we only want to set it if it's not already set
    set_utm_cookie('ft', Time.now.getutc.to_i) unless cookies[:ft]

    # These are the things we'll be tracking through the customer dashboard
    set_utm_cookie('utm_source', 'developer.nexmo.com')
    set_utm_cookie('utm_medium', 'referral')
    set_utm_cookie('utm_campaign', campaign)

    # We don't use term or content as it's not paid, but they may have been set by other things
    # If they were, delete them so our data isn't tainted
    cookies.delete('utm_term', domain: :all)
    cookies.delete('utm_content', domain: :all)
  end

  def set_utm_cookie(name, value)
    cookies[name] = {
      value: value,
      expires: 1.year.from_now,
      domain: :all,
    }
  end
end
