class TooltipFilter < Banzai::Filter
  def call(input)
    input.gsub(/\^\[([a-zA-Z0-9\s:\-]+)\]\((.+?)\)/) do
      tooltip = <<~HEREDOC
        <span class="Vlt-tooltip Vlt-tooltip--top" title="#{$2}" tabindex="0">
        	#{$1}&nbsp;
        	<svg class="Vlt-icon Vlt-icon--smaller Vlt-icon--text-bottom Vlt-blue" aria-hidden="true"><use xlink:href="/symbol/volta-icons.svg#Vlt-icon-help-negative"/></svg>
        </span>
      HEREDOC

      "FREEZESTART#{Base64.urlsafe_encode64(tooltip)}FREEZEEND"
    end
  end
end
