class TooltipFilter < Banzai::Filter
  def call(input)
    input.gsub(/\^\[([a-zA-Z0-9\s:\-]+)\]\((.+?)\)/) do
      tooltip = <<~HEREDOC
        <span class="tooltip" data-text="#{$2}" tabindex="0">#{$1}</span>
      HEREDOC

      "FREEZESTART#{Base64.urlsafe_encode64(tooltip)}FREEZEEND"
    end
  end
end
