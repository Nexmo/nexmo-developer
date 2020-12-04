# -*- coding: utf-8 -*-

require 'woothee/dataset'
require 'woothee/util'

module Woothee::OS
  extend Woothee::Util

  def self.challenge_windows(ua, result)
    return false if ua.index("Windows").nil?

    # Xbox Series
    if ua.index("Xbox")
      data = if ua.index("Xbox; Xbox One)")
               Woothee::DataSet.get("XboxOne")
             else
               Woothee::DataSet.get("Xbox360")
             end
      # update browser as appliance
      update_map(result, data)
      return true
    end

    data = Woothee::DataSet.get('Win')
    unless ua =~ /Windows ([ .a-zA-Z0-9]+)[;\\)]/o
      # Windows, but version unknown
      update_category(result, data[Woothee::KEY_CATEGORY])
      update_os(result, data[Woothee::KEY_NAME])
      return true
    end

    version = $1
    data = case
           when version == 'NT 10.0' then Woothee::DataSet.get('Win10')
           when version == 'NT 6.3' then Woothee::DataSet.get('Win8.1')
           when version == 'NT 6.2' then Woothee::DataSet.get('Win8')
           when version == 'NT 6.1' then Woothee::DataSet.get('Win7')
           when version == 'NT 6.0' then Woothee::DataSet.get('WinVista')
           when version == 'NT 5.1' then Woothee::DataSet.get('WinXP')
           when version =~ /^Phone(?: OS)? ([.0-9]+)/o
             version = $1
             Woothee::DataSet.get('WinPhone')
           when version == 'NT 5.0' then Woothee::DataSet.get('Win2000')
           when version == 'NT 4.0' then Woothee::DataSet.get('WinNT4')
           when version == '98' then Woothee::DataSet.get('Win98') # wow, WinMe is shown as 'Windows 98; Win9x 4.90', fxxxk
           when version == '95' then Woothee::DataSet.get('Win95')
           when version == 'CE' then Woothee::DataSet.get('WinCE')
           else
             data # windows unknown version
           end
    update_category(result, data[Woothee::KEY_CATEGORY])
    update_os(result, data[Woothee::KEY_NAME])
    update_os_version(result, version)
    true
  end

  def self.challenge_osx(ua, result)
    return false if ua.index('Mac OS X').nil?

    data = Woothee::DataSet.get('OSX')
    version = nil
    if ua.index('like Mac OS X')
      data = case
             when ua.index('iPhone;') then Woothee::DataSet.get('iPhone')
             when ua.index('iPad;') then Woothee::DataSet.get('iPad')
             when ua.index('iPod') then Woothee::DataSet.get('iPod')
             else data
             end
      if ua =~ /; CPU(?: iPhone)? OS (\d+_\d+(?:_\d+)?) like Mac OS X/
        version = $1.gsub(/_/, '.')
      end
    else
      if ua =~ /Mac OS X (10[._]\d+(?:[._]\d+)?)(?:\)|;)/
        version = $1.gsub(/_/, '.')
      end
    end
    update_category(result, data[Woothee::KEY_CATEGORY])
    update_os(result, data[Woothee::KEY_NAME])
    if version
      update_os_version(result, version)
    end
    true
  end

  def self.challenge_linux(ua, result)
    return false if ua.index('Linux').nil?

    data = nil
    os_version = nil
    if ua.index('Android')
      data = Woothee::DataSet.get('Android')
      if ua =~ /Android[- ](\d+(?:\.\d+(?:\.\d+)?)?)/
        os_version = $1
      end
    else
      data = Woothee::DataSet.get('Linux')
    end
    update_category(result, data[Woothee::KEY_CATEGORY])
    update_os(result, data[Woothee::KEY_NAME])
    if os_version
      update_os_version(result, os_version)
    end
    true
  end

  def self.challenge_smartphone(ua, result)
    data = nil
    os_version = nil
    case
    when ua.index('iPhone')
      data = Woothee::DataSet.get('iPhone')
    when ua.index('iPad')
      data = Woothee::DataSet.get('iPad')
    when ua.index('iPod')
      data = Woothee::DataSet.get('iPod')
    when ua.index('Android')
      data = Woothee::DataSet.get('Android')
    when ua.index('CFNetwork')
      data = Woothee::DataSet.get('iOS')
    when ua.index('BB10')
      data = Woothee::DataSet.get('BlackBerry10')
      if ua =~ /BB10(?:.+)Version\/([.0-9]+)/
        os_version = $1
      end
    when ua.index('BlackBerry')
      data = Woothee::DataSet.get('BlackBerry')
      if ua =~ /BlackBerry(?:\d+)\/([.0-9]+) /
        os_version = $1
      end
    end

    if result[Woothee::KEY_NAME] && result[Woothee::KEY_NAME] == Woothee::DataSet.get('Firefox')[Woothee::KEY_NAME]
      # Firefox OS specific pattern
      # http://lawrencemandel.com/2012/07/27/decision-made-firefox-os-user-agent-string/
      # https://github.com/woothee/woothee/issues/2
      if ua =~ /^Mozilla\/[.0-9]+ \((?:Mobile|Tablet);(?:.*;)? rv:([.0-9]+)\) Gecko\/[.0-9]+ Firefox\/[.0-9]+$/
        data = Woothee::DataSet.get('FirefoxOS')
        os_version = $1
      end
    end

    return false unless data

    update_category(result, data[Woothee::KEY_CATEGORY])
    update_os(result, data[Woothee::KEY_NAME])
    if os_version
      update_os_version(result, os_version)
    end
    true
  end

  def self.challenge_mobilephone(ua, result)
    if ua.index('KDDI-')
      if ua =~ /KDDI-([^- \/;()"']+)/o
        term = $1
        data = Woothee::DataSet.get('au')
        update_category(result, data[Woothee::KEY_CATEGORY])
        update_os(result, data[Woothee::KEY_OS])
        update_version(result, term)
        return true
      end
    end
    if ua.index('WILLCOM') or ua.index('DDIPOCKET')
      if ua =~ /(?:WILLCOM|DDIPOCKET);[^\/]+\/([^ \/;()]+)/o
        term = $1
        data = Woothee::DataSet.get('willcom')
        update_category(result, data[Woothee::KEY_CATEGORY])
        update_os(result, data[Woothee::KEY_OS])
        update_version(result, term)
        return true
      end
    end
    if ua.index('SymbianOS')
      data = Woothee::DataSet.get('SymbianOS')
      update_category(result, data[Woothee::KEY_CATEGORY])
      update_os(result, data[Woothee::KEY_OS])
      return true
    end
    if ua.index('Google Wireless Transcoder')
      update_map(result, Woothee::DataSet.get('MobileTranscoder'))
      update_version(result, 'Google')
      return true
    end
    if ua.index('Naver Transcoder')
      update_map(result, Woothee::DataSet.get('MobileTranscoder'))
      update_version(result, 'Naver')
      return true
    end

    false
  end

  def self.challenge_appliance(ua, result)
    if ua.index('Nintendo DSi;')
      data = Woothee::DataSet.get('NintendoDSi')
      update_category(result, data[Woothee::KEY_CATEGORY])
      update_os(result, data[Woothee::KEY_OS])
      return true
    end
    if ua.index('Nintendo Wii;')
      data = Woothee::DataSet.get('NintendoWii')
      update_category(result, data[Woothee::KEY_CATEGORY])
      update_os(result, data[Woothee::KEY_OS])
      return true
    end

    false
  end

  def self.challenge_misc(ua, result)
    data = nil
    os_version = nil
    case
    when ua.index('(Win98;')
      data = Woothee::DataSet.get('Win98')
      os_version = "98"
    when ua.index('Macintosh; U; PPC;')
      data = Woothee::DataSet.get('MacOS')
      if ua =~ /rv:(\d+\.\d+\.\d+)/
        os_version = $1
      end
    when ua.index('Mac_PowerPC')
      data = Woothee::DataSet.get('MacOS')
    when ua.index('X11; FreeBSD ')
      data = Woothee::DataSet.get('BSD')
      if ua =~ /FreeBSD ([^;\)]+);/
        os_version = $1
      end
    when ua.index('X11; CrOS ')
      data = Woothee::DataSet.get('ChromeOS')
      if ua =~ /CrOS ([^\)]+)\)/
        os_version = $1
      end
    else
      nil
    end

    if data
      update_category(result, data[Woothee::KEY_CATEGORY])
      update_os(result, data[Woothee::KEY_NAME])
      if os_version
        update_os_version(result, os_version)
      end
      return true
    end

    false
  end
end
