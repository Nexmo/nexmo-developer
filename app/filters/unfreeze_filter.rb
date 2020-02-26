class UnfreezeFilter < Banzai::Filter
  def call(input)
    input.gsub!('FREEZESTARTFREEZEEND', '')
    input.gsub!('<p>FREEZESTART', 'FREEZESTART')
    input.gsub!('FREEZEEND</p>', 'FREEZEEND')

    input.gsub!(/FREEZESTART(.+?)FREEZEEND/m) do |_s|
      Base64.urlsafe_decode64($1).force_encoding(Encoding::UTF_8)
    end
    input
  end
end
