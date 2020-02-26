class LanguageFilter < Banzai::Filter
  def call(input)
    input.gsub(/\[(.+?)\]\(lang:.+?(?:'(.+?)'|"(.+?)")\)/) do |_s|
      "<span lang='#{$2}'>#{$1}</span>"
    end
  end
end
