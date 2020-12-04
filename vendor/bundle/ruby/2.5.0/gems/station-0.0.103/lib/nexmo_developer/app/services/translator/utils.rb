module Translator
  module Utils
    def locale_without_region(locale)
      case locale
      when 'zh-CN', 'cn'
        :cn
      when 'ja', 'ja-JP'
        :ja
      else
        :en
      end
    end

    def locale_with_region(locale)
      case locale.to_s
      when 'ja', 'ja-JP'
        'ja-JP'
      when 'cn', 'zh-CN'
        'zh-CN'
      else
        locale.to_s
      end
    end

    def storage_folder(filename, locale)
      if filename.starts_with? '_documentation'
        dir_path = Pathname.new(file_uri(filename)).dirname.to_s
        "#{Rails.configuration.docs_base_path}/_documentation/#{locale}/#{dir_path}"
      elsif filename.starts_with? '_use_cases'
        "#{Rails.configuration.docs_base_path}/_use_cases/#{locale}"
      elsif filename.starts_with? 'config/locales'
        Pathname.new(file_uri(filename)).dirname.to_s
      elsif filename.starts_with? 'config/tutorials'
        pathname = Pathname.new(filename.gsub("config/tutorials/#{I18n.default_locale}/", ''))
        dir_path = pathname.dirname.to_s == '.' ? '' : "/#{pathname.dirname}"
        "#{Rails.configuration.docs_base_path}/config/tutorials/#{locale}#{dir_path}"
      elsif filename.starts_with? '_tutorials'
        pathname = Pathname.new(filename.gsub("_tutorials/#{I18n.default_locale}/", ''))
        dir_path = pathname.dirname.to_s == '.' ? '' : "/#{pathname.dirname}"
        "#{Rails.configuration.docs_base_path}/_tutorials/#{locale}#{dir_path}"
      else
        dir_path = Pathname.new(file_uri(filename)).dirname.to_s
        "#{Rails.configuration.docs_base_path}/_documentation/#{locale}/#{dir_path}"
      end
    end

    def file_path(filename, locale)
      folder = storage_folder(filename, locale)
      file_name = if filename.starts_with? '_documentation'
                    Pathname.new(file_uri(filename)).basename.to_s
                  elsif filename.starts_with? 'config/locales'
                    "#{locale}#{Pathname.new(file_uri(filename)).extname}"
                  else
                    Pathname.new(file_uri(filename)).basename.to_s
                  end
      "#{folder}/#{file_name}"
    end

    def file_uri(filename)
      if filename.starts_with? '_documentation'
        filename.gsub(%r{_documentation/[a-z]{2}/}, '')
      else
        filename.gsub(%r{(_use_cases|_tutorials|config/tutorials)/#{I18n.default_locale}/(.*)}) do |_|
          "#{$1}/#{$2}"
        end
      end
    end
  end
end
