class TechioFilter < Banzai::Filter
  def call(input)
    input.gsub(/```techio(.+?)```/m) do |_s|
      config = YAML.safe_load($1)

      techio = <<~HEREDOC
        <div class="techio-container">
          <iframe width="100%" frameborder="0" scrolling="no" allowtransparency="true" style="visibility: hidden" src="https://tech.io/playground-widget#{config['path']}/#{config['title']}"></iframe>
          <script>if(typeof window.techioScriptInjected==="undefined"){window.techioScriptInjected=true;var d=document,s=d.createElement("script");s.src="https://files.codingame.com/codingame/iframe-v-1-4.js";(d.head||d.body).appendChild(s);}</script>
        </div>
      HEREDOC

      "FREEZESTART#{Base64.urlsafe_encode64(techio)}FREEZEEND"
    end
  end
end
