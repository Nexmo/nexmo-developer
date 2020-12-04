# -*- coding: utf-8 -*-

require 'woothee/dataset'
require 'woothee/util'

module Woothee::Appliance
  extend Woothee::Util

  def self.challenge_playstation(ua, result)
    data = nil
    os_version = nil
    case
    when ua.index('PSP (PlayStation Portable);')
      data = Woothee::DataSet.get('PSP')
      if ua =~ /PSP \(PlayStation Portable\); ([.0-9]+)\)/
        os_version = $1
      end
    when ua.index('PlayStation Vita')
      data = Woothee::DataSet.get('PSVita')
      if ua =~ /PlayStation Vita ([.0-9]+)\)/
        os_version = $1
      end
    when ua.index('PLAYSTATION 3 ') || ua.index('PLAYSTATION 3;')
      data = Woothee::DataSet.get('PS3')
      if ua =~ /PLAYSTATION 3;? ([.0-9]+)\)/
        os_version = $1
      end
    when ua.index('PlayStation 4 ')
      data = Woothee::DataSet.get('PS4')
      if ua =~ /PlayStation 4 ([.0-9]+)\)/
        os_version = $1
      end
    end
    return false unless data

    update_map(result, data)
    if os_version
      update_os_version(result, os_version)
    end
    true
  end

  def self.challenge_nintendo(ua, result)
    data = case
           when ua.index('Nintendo 3DS;') then Woothee::DataSet.get('Nintendo3DS')
           when ua.index('Nintendo DSi;') then Woothee::DataSet.get('NintendoDSi')
           when ua.index('Nintendo Wii;') then Woothee::DataSet.get('NintendoWii')
           when ua.index('(Nintendo WiiU)') then Woothee::DataSet.get('NintendoWiiU')
           else nil
           end
    return false unless data

    update_map(result, data)
    true
  end

  def self.challenge_digitaltv(ua, result)
    data = if ua.index('InettvBrowser/')
             Woothee::DataSet.get('DigitalTV')
           else
             nil
           end
    return false unless data

    update_map(result, data)
    true
  end
end
