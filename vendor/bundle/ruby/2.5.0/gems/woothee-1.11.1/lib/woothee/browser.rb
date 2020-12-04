# -*- coding: utf-8 -*-

require 'woothee/dataset'
require 'woothee/util'

module Woothee::Browser
  extend Woothee::Util

  def self.challenge_msie(ua, result)
    return false if ua.index("compatible; MSIE").nil? && ua.index("Trident/").nil? && ua.index("IEMobile").nil?

    version = if ua =~ /MSIE ([.0-9]+);/o
                $1
              elsif ua =~ /Trident\/([.0-9]+);/o && ua =~ / rv:([.0-9]+)/
                $1
              elsif ua =~ /IEMobile\/([.0-9]+);/o
                $1
              else
                Woothee::VALUE_UNKNOWN
              end
    update_map(result, Woothee::DataSet.get('MSIE'))
    update_version(result, version)
    true
  end

  def self.challenge_yandexbrowser(ua, result)
    return false if ua.index('YaBrowser/').nil?

    version = Woothee::VALUE_UNKNOWN
    if ua =~ /YaBrowser\/([.0-9]+)/o
      version = $1
    end

    update_map(result, Woothee::DataSet.get('YaBrowser'))
    update_version(result, version)
    true
  end

  def self.challenge_safari_chrome(ua, result)
    return false if ua.index('Safari/').nil?
    return false if ua.index('Chrome') && ua.index('wv')

    version = Woothee::VALUE_UNKNOWN

    # Edge
    if ua =~ /(?:Edge|Edg|EdgiOS|EdgA)\/([.0-9]+)/o
      version = $1
      update_map(result, Woothee::DataSet.get('Edge'))
      update_version(result, version)
      return true
    end

    if ua =~ /FxiOS\/([.0-9]+)/o
      version = $1
      update_map(result, Woothee::DataSet.get('Firefox'))
      update_version(result, version)
      return true
    end

    if ua =~ /(?:Chrome|CrMo|CriOS)\/([.0-9]+)/o
      chrome_version = $1

      if ua =~ /OPR\/([.0-9]+)/o
        version = $1
        update_map(result, Woothee::DataSet.get('Opera'))
        update_version(result, version)
        return true
      end

      # Chrome
      version = chrome_version
      update_map(result, Woothee::DataSet.get('Chrome'))
      update_version(result, version)
      return true
    end

    # Google Search App
    if ua =~ /GSA\/([.0-9]+)/o
      version = $1
      update_map(result, Woothee::DataSet.get("GSA"))
      update_version(result, version)
      return true
    end

    # Safari
    if ua =~ /Version\/([.0-9]+)/o
      version = $1
    end
    update_map(result, Woothee::DataSet.get('Safari'))
    update_version(result, version)
    true
  end

  def self.challenge_firefox(ua, result)
    return false if ua.index('Firefox/').nil?

    version = if ua =~ /Firefox\/([.0-9]+)/o
                $1
              else
                Woothee::VALUE_UNKNOWN
              end
    update_map(result, Woothee::DataSet.get('Firefox'))
    update_version(result, version)
    true
  end

  def self.challenge_opera(ua, result)
    return false if ua.index('Opera').nil?

    version = if ua =~ /Version\/([.0-9]+)/o
                $1
              elsif ua =~ /Opera[\/ ]([.0-9]+)/o
                $1
              else
                Woothee::VALUE_UNKNOWN
              end
    update_map(result, Woothee::DataSet.get('Opera'))
    update_version(result, version)
    true
  end

  def self.challenge_webview(ua, result)
    # Android(Lollipop and Above)
    if ua.index('Chrome') && ua.index('wv')
      version = if ua =~ /Version\/([.0-9]+)/
                  $1
                else
                  Woothee::VALUE_UNKNOWN
                end

      update_map(result, Woothee::DataSet.get('Webview'))
      update_version(result, version)
      return true
    end

    # iOS
    if ua =~ /iP(?:hone;|ad;|od) .*like Mac OS X/
      return false if ua.index('Safari/')

      version = if ua =~ /Version\/([.0-9]+)/
                  $1
                else
                  Woothee::VALUE_UNKNOWN
                end
      update_map(result, Woothee::DataSet.get('Webview'))
      update_version(result, version)
      return true
    end

    false
  end

  def self.challenge_sleipnir(ua, result)
    return false if ua.index('Sleipnir/').nil?

    version = if ua =~ /Sleipnir\/([.0-9]+)/o
                $1
              else
                Woothee::VALUE_UNKNOWN
              end
    update_map(result, Woothee::DataSet.get('Sleipnir'))
    update_version(result, version)

    # Sleipnir's user-agent doesn't contain Windows version, so put 'Windows UNKNOWN Ver'.
    # Sleipnir is IE component browser, so for Windows only.
    win = Woothee::DataSet.get('Win')
    update_category(result, win[Woothee::KEY_CATEGORY])
    update_os(result, win[Woothee::KEY_NAME])

    true
  end

  def self.challenge_vivaldi(ua, result)
    return false if ua.index('Vivaldi/').nil?

    version = if ua =~ /Vivaldi\/([.0-9]+)/o
                $1
              else
                Woothee::VALUE_UNKNOWN
              end
    update_map(result, Woothee::DataSet.get('Vivaldi'))
    update_version(result, version)
  end
end
