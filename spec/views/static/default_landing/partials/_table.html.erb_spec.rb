require 'rails_helper'

RSpec.describe 'rendering _table landing page partial' do
  it 'renders correctly with local variable' do
    render partial: '/static/default_landing/partials/table.html.erb', locals: {
        'head' => [
          { 'content' => 'Header 1' },
          { 'content' => 'Header 2' },
        ],
        'body' => [
          'row' =>
          [
            { 'column' => 'Row 1 Text 1' },
            { 'column' => 'Row 1 Text 2' },
          ],
        ],
    }

    expect(rendered).to include("<div class=\"Vlt-table\">\n")
    expect(rendered).to include('<th>Header 1</th>')
    expect(rendered).to include("<td><p>Row 1 Text 1</p></td>\n")
  end

  it 'raises an error if the head key is not provided' do
    expect do
      render partial: '/static/default_landing/partials/table.html.erb', locals: {
        'body' => [
          'row' =>
          [
            { 'column' => 'Row 1 Text 1' },
            { 'column' => 'Row 1 Text 2' },
          ],
        ],
      }
    end .to raise_error("Missing 'head' key in table landing page block")
  end

  it 'raises an error if the body key is not provided' do
    expect do
      render partial: '/static/default_landing/partials/table.html.erb', locals: {
        'head' => [
          { 'content' => 'Header 1' },
          { 'content' => 'Header 2' },
        ],
      }
    end .to raise_error("Missing 'body' key in table landing page block")
  end
end
