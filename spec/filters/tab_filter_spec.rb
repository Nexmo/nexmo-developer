require 'rails_helper'

RSpec.describe TabFilter do
  before do
    allow(File).to receive(:exist?).and_call_original
  end

  context 'when no config is provided' do
    it 'raises an exception' do
      input = <<~HEREDOC
        ```tabbed_examples
        ```
      HEREDOC

      expect do
        described_class.new.call(input)
      end.to raise_error('Source or tabs must be present in this tabbed_example config')
    end
  end

  context 'when an invalid config is provided' do
    it 'raises an exception' do
      input = <<~HEREDOC
        ```tabbed_examples
        foo: 'bar'
        ```
      HEREDOC

      expect do
        described_class.new.call(input)
      end.to raise_error('Source or tabs must be present in this tabbed_example config')
    end
  end

  it 'when content is not a tab filter, nothing happens' do
    input = 'test content is ignored'
    actual = described_class.new.call(input)
    expect(actual).to eq(input)
  end

  context 'when input is a directory' do
    let(:path) { 'path/to/a/directory' }

    it 'raises an exception if tabbed parameter is not set to true' do
      expect(File).to receive(:directory?).with("#{Rails.configuration.docs_base_path}/#{path}").and_return(true)
      expect(File).to receive(:read).with("#{Rails.configuration.docs_base_path}/#{path}/.config.yml").and_return(config_tabbed_false)
      input = <<~HEREDOC
        ```tabbed_folder
        source: #{path}
        ```
      HEREDOC
      expect do
        described_class.new.call(input)
      end.to raise_error('Tabbed must be set to true in the folder config YAML file')
    end

    it 'raises an exception if source path is not a directory' do
      expect(File).to receive(:directory?).with("#{Rails.configuration.docs_base_path}/#{path}").and_return(false)
      input = <<~HEREDOC
        ```tabbed_folder
        source: #{path}
        ```
      HEREDOC
      expect do
        described_class.new.call(input)
      end.to raise_error('path/to/a/directory is not a directory')
    end

    it 'raises an error if there are no files in input directory' do
      expect(File).to receive(:directory?).with("#{Rails.configuration.docs_base_path}/#{path}").and_return(true)
      expect(File).to receive(:read).with("#{Rails.configuration.docs_base_path}/#{path}/.config.yml").and_return(config_tabbed_true)
      expect(Dir).to receive(:glob).with("#{Rails.configuration.docs_base_path}/#{path}/*.md").and_return([])
      input = <<~HEREDOC
        ```tabbed_folder
        source: #{path}
        ```
      HEREDOC
      expect do
        described_class.new.call(input)
      end.to raise_error("Empty content_from_source file list in #{Rails.configuration.docs_base_path}/#{path}/*.md")
    end

    it 'renders content with one markdown file in input' do
      expect(File).to receive(:directory?).with("#{Rails.configuration.docs_base_path}/#{path}").and_return(true)
      expect(File).to receive(:read).with("#{Rails.configuration.docs_base_path}/#{path}/.config.yml").and_return(config_tabbed_true)
      expect(Dir).to receive(:glob).with("#{Rails.configuration.docs_base_path}/#{path}/*.md").and_return(["#{Rails.configuration.docs_base_path}/#{path}/javascript.md"])
      mock_content('javascript', first_sample_markdown)
      expect(SecureRandom).to receive(:hex).once.and_return('ID123456')

      input = <<~HEREDOC
        ```tabbed_folder
        source: "#{path}"
        ```
      HEREDOC
      expected_output = "FREEZESTARTPGRpdiBjbGFzcz0iVmx0LXRhYnMiPgogIDxkaXYgY2xhc3M9IlZsdC10YWJzX19oZWFkZXIgVmx0LXRhYnNfX2hlYWRlci0tYm9yZGVyZWQiIGRhdGEtaGFzLWluaXRpYWwtdGFiPSJmYWxzZSI-PGRpdiBjbGFzcz0iVmx0LXRhYnNfX2xpbmsgVmx0LXRhYnNfX2xpbmtfYWN0aXZlIiByb2xlPSJ0YWIiIGRhdGEtbGFuZ3VhZ2U9ImphdmFzY3JpcHQiIGRhdGEtbGFuZ3VhZ2UtdHlwZT0ibGFuZ3VhZ2VzIiBkYXRhLWxhbmd1YWdlLWxpbmthYmxlPSJ0cnVlIj48c3Bhbj48c3ZnPjx1c2UgeGxpbms6aHJlZj0iL2Fzc2V0cy9pbWFnZXMvYnJhbmRzL2phdmFzY3JpcHQuc3ZnI2phdmFzY3JpcHQiPjwvdXNlPjwvc3ZnPjxzcGFuPkZpcnN0IFNhbXBsZSBNYXJrZG93bjwvc3Bhbj48L3NwYW4-PC9kaXY-PC9kaXY-CiAgICA8ZGl2IGNsYXNzPSJWbHQtdGFic19fY29udGVudCI-CiAgICA8ZGl2IGNsYXNzPSJWbHQtdGFic19fcGFuZWwgVmx0LXRhYnNfX3BhbmVsX2FjdGl2ZSI-PHAgYXJpYS1sYWJlbGxlZGJ5PSciSUQxMjM0NTYiJyBhcmlhLWhpZGRlbj0idHJ1ZSI-PHA-ICMjIEhlYWRpbmcKIFNhbXBsZSBjb250ZW50PC9wPjwvcD48L2Rpdj4KPC9kaXY-CjwvZGl2Pgo=FREEZEEND\n"
      expect(described_class.new.call(input)).to eq(expected_output)
    end

    it 'renders content with two markdown files in input' do
      expect(File).to receive(:directory?).with("#{Rails.configuration.docs_base_path}/#{path}").and_return(true)
      expect(File).to receive(:read).with("#{Rails.configuration.docs_base_path}/#{path}/.config.yml").and_return(config_tabbed_true)
      expect(Dir).to receive(:glob).with("#{Rails.configuration.docs_base_path}/#{path}/*.md").and_return(["#{Rails.configuration.docs_base_path}/#{path}/javascript.md", "#{Rails.configuration.docs_base_path}/#{path}/android.md"])
      mock_content('javascript', first_sample_markdown)
      mock_content('android', second_sample_markdown)
      expect(SecureRandom).to receive(:hex).twice.and_return('ID123456')

      input = <<~HEREDOC
        ```tabbed_folder
        source: #{path}
        ```
      HEREDOC
      expected_output = "FREEZESTARTPGRpdiBjbGFzcz0iVmx0LXRhYnMiPgogIDxkaXYgY2xhc3M9IlZsdC10YWJzX19oZWFkZXIgVmx0LXRhYnNfX2hlYWRlci0tYm9yZGVyZWQiIGRhdGEtaGFzLWluaXRpYWwtdGFiPSJmYWxzZSI-CjxkaXYgY2xhc3M9IlZsdC10YWJzX19saW5rIFZsdC10YWJzX19saW5rX2FjdGl2ZSIgcm9sZT0idGFiIiBkYXRhLWxhbmd1YWdlPSJqYXZhc2NyaXB0IiBkYXRhLWxhbmd1YWdlLXR5cGU9Imxhbmd1YWdlcyIgZGF0YS1sYW5ndWFnZS1saW5rYWJsZT0idHJ1ZSI-PHNwYW4-PHN2Zz48dXNlIHhsaW5rOmhyZWY9Ii9hc3NldHMvaW1hZ2VzL2JyYW5kcy9qYXZhc2NyaXB0LnN2ZyNqYXZhc2NyaXB0Ij48L3VzZT48L3N2Zz48c3Bhbj5GaXJzdCBTYW1wbGUgTWFya2Rvd248L3NwYW4-PC9zcGFuPjwvZGl2Pgo8ZGl2IGNsYXNzPSJWbHQtdGFic19fbGluayIgcm9sZT0idGFiIiBkYXRhLWxhbmd1YWdlPSJqYXZhc2NyaXB0IiBkYXRhLWxhbmd1YWdlLXR5cGU9Imxhbmd1YWdlcyIgZGF0YS1sYW5ndWFnZS1saW5rYWJsZT0idHJ1ZSI-PHNwYW4-PHN2Zz48dXNlIHhsaW5rOmhyZWY9Ii9hc3NldHMvaW1hZ2VzL2JyYW5kcy9qYXZhc2NyaXB0LnN2ZyNqYXZhc2NyaXB0Ij48L3VzZT48L3N2Zz48c3Bhbj5TZWNvbmQgU2FtcGxlIE1hcmtkb3duPC9zcGFuPjwvc3Bhbj48L2Rpdj4KPC9kaXY-CiAgICA8ZGl2IGNsYXNzPSJWbHQtdGFic19fY29udGVudCI-CiAgICA8ZGl2IGNsYXNzPSJWbHQtdGFic19fcGFuZWwgVmx0LXRhYnNfX3BhbmVsX2FjdGl2ZSI-PHAgYXJpYS1sYWJlbGxlZGJ5PSciSUQxMjM0NTYiJyBhcmlhLWhpZGRlbj0idHJ1ZSI-PHA-ICMjIEhlYWRpbmcKIFNhbXBsZSBjb250ZW50PC9wPjwvcD48L2Rpdj4KPGRpdiBjbGFzcz0iVmx0LXRhYnNfX3BhbmVsIj48cCBhcmlhLWxhYmVsbGVkYnk9JyJJRDEyMzQ1NiInIGFyaWEtaGlkZGVuPSJ0cnVlIj48cD4gIyMgSGVhZGluZwogU2FtcGxlIGNvbnRlbnQ8L3A-PC9wPjwvZGl2Pgo8L2Rpdj4KPC9kaXY-Cg==FREEZEEND\n"
      expect(described_class.new.call(input)).to eq(expected_output)
    end

    it 'renders content with three markdown files in input' do
      expect(File).to receive(:directory?).with("#{Rails.configuration.docs_base_path}/#{path}").and_return(true)
      expect(File).to receive(:read).with("#{Rails.configuration.docs_base_path}/#{path}/.config.yml").and_return(config_tabbed_true)
      expect(Dir).to receive(:glob).with("#{Rails.configuration.docs_base_path}/#{path}/*.md").and_return(["#{Rails.configuration.docs_base_path}/#{path}/javascript.md", "#{Rails.configuration.docs_base_path}/#{path}/android.md", "#{Rails.configuration.docs_base_path}/#{path}/ios.md"])
      mock_content('javascript', first_sample_markdown)
      mock_content('android', second_sample_markdown)
      mock_content('ios', third_sample_markdown)
      expect(SecureRandom).to receive(:hex).exactly(3).times.and_return('ID123456')

      input = <<~HEREDOC
        ```tabbed_folder
        source: 'path/to/a/directory'
        ```
      HEREDOC
      expected_output = "FREEZESTARTPGRpdiBjbGFzcz0iVmx0LXRhYnMiPgogIDxkaXYgY2xhc3M9IlZsdC10YWJzX19oZWFkZXIgVmx0LXRhYnNfX2hlYWRlci0tYm9yZGVyZWQiIGRhdGEtaGFzLWluaXRpYWwtdGFiPSJmYWxzZSI-CjxkaXYgY2xhc3M9IlZsdC10YWJzX19saW5rIFZsdC10YWJzX19saW5rX2FjdGl2ZSIgcm9sZT0idGFiIiBkYXRhLWxhbmd1YWdlPSJqYXZhc2NyaXB0IiBkYXRhLWxhbmd1YWdlLXR5cGU9Imxhbmd1YWdlcyIgZGF0YS1sYW5ndWFnZS1saW5rYWJsZT0idHJ1ZSI-PHNwYW4-PHN2Zz48dXNlIHhsaW5rOmhyZWY9Ii9hc3NldHMvaW1hZ2VzL2JyYW5kcy9qYXZhc2NyaXB0LnN2ZyNqYXZhc2NyaXB0Ij48L3VzZT48L3N2Zz48c3Bhbj5GaXJzdCBTYW1wbGUgTWFya2Rvd248L3NwYW4-PC9zcGFuPjwvZGl2Pgo8ZGl2IGNsYXNzPSJWbHQtdGFic19fbGluayIgcm9sZT0idGFiIiBkYXRhLWxhbmd1YWdlPSJqYXZhc2NyaXB0IiBkYXRhLWxhbmd1YWdlLXR5cGU9Imxhbmd1YWdlcyIgZGF0YS1sYW5ndWFnZS1saW5rYWJsZT0idHJ1ZSI-PHNwYW4-PHN2Zz48dXNlIHhsaW5rOmhyZWY9Ii9hc3NldHMvaW1hZ2VzL2JyYW5kcy9qYXZhc2NyaXB0LnN2ZyNqYXZhc2NyaXB0Ij48L3VzZT48L3N2Zz48c3Bhbj5TZWNvbmQgU2FtcGxlIE1hcmtkb3duPC9zcGFuPjwvc3Bhbj48L2Rpdj4KPGRpdiBjbGFzcz0iVmx0LXRhYnNfX2xpbmsiIHJvbGU9InRhYiIgZGF0YS1sYW5ndWFnZT0iamF2YXNjcmlwdCIgZGF0YS1sYW5ndWFnZS10eXBlPSJsYW5ndWFnZXMiIGRhdGEtbGFuZ3VhZ2UtbGlua2FibGU9InRydWUiPjxzcGFuPjxzdmc-PHVzZSB4bGluazpocmVmPSIvYXNzZXRzL2ltYWdlcy9icmFuZHMvamF2YXNjcmlwdC5zdmcjamF2YXNjcmlwdCI-PC91c2U-PC9zdmc-PHNwYW4-VGhpcmQgU2FtcGxlIE1hcmtkb3duPC9zcGFuPjwvc3Bhbj48L2Rpdj4KPC9kaXY-CiAgICA8ZGl2IGNsYXNzPSJWbHQtdGFic19fY29udGVudCI-CiAgICA8ZGl2IGNsYXNzPSJWbHQtdGFic19fcGFuZWwgVmx0LXRhYnNfX3BhbmVsX2FjdGl2ZSI-PHAgYXJpYS1sYWJlbGxlZGJ5PSciSUQxMjM0NTYiJyBhcmlhLWhpZGRlbj0idHJ1ZSI-PHA-ICMjIEhlYWRpbmcKIFNhbXBsZSBjb250ZW50PC9wPjwvcD48L2Rpdj4KPGRpdiBjbGFzcz0iVmx0LXRhYnNfX3BhbmVsIj48cCBhcmlhLWxhYmVsbGVkYnk9JyJJRDEyMzQ1NiInIGFyaWEtaGlkZGVuPSJ0cnVlIj48cD4gIyMgSGVhZGluZwogU2FtcGxlIGNvbnRlbnQ8L3A-PC9wPjwvZGl2Pgo8ZGl2IGNsYXNzPSJWbHQtdGFic19fcGFuZWwiPjxwIGFyaWEtbGFiZWxsZWRieT0nIklEMTIzNDU2IicgYXJpYS1oaWRkZW49InRydWUiPjxwPiAjIyBIZWFkaW5nCiBTYW1wbGUgY29udGVudDwvcD48L3A-PC9kaXY-CjwvZGl2Pgo8L2Rpdj4KFREEZEEND\n"
      expect(described_class.new.call(input)).to eq(expected_output)
    end
  end

  def config_tabbed_false
    <<~HEREDOC
      ---
      tabbed: false
    HEREDOC
  end

  def config_tabbed_true
    <<~HEREDOC
      ---
      tabbed: true
    HEREDOC
  end

  def first_sample_markdown
    <<~HEREDOC
      ---
      title: First Sample Markdown
      language: javascript
      ---
       ## Heading
       Sample content
    HEREDOC
  end

  def second_sample_markdown
    <<~HEREDOC
      ---
      title: Second Sample Markdown
      language: javascript
      ---
       ## Heading
       Sample content
    HEREDOC
  end

  def third_sample_markdown
    <<~HEREDOC
      ---
      title: Third Sample Markdown
      language: javascript
      ---
       ## Heading
       Sample content
    HEREDOC
  end

  def mock_content(name, content)
    expect(File).to receive(:exist?).with("#{Rails.configuration.docs_base_path}/path/to/a/directory/#{name}.md").and_return(true)
    expect(File).to receive(:read).with("#{Rails.configuration.docs_base_path}/path/to/a/directory/#{name}.md").and_return(content)
  end
end
