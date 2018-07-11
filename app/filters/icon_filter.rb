class IconFilter < Banzai::Filter
  def call(input)
    input.gsub!('✅', '<i class="icon icon--large icon-check-circle color--success"></i>')
    input.gsub!('❎', '<i class="icon icon--large icon-times-circle color--error"></i>')

    input.gsub!(/\[icon="(.+?)"\]/) do
      <<~HEREDOC
        <i class="icon icon-#{$1}"></i>
      HEREDOC
    end

    input
  end
end
