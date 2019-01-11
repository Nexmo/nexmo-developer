require 'rails_helper'

describe '/static/default_landing' do
  it 'renders single column with 100% width' do
    @config = {
        'rows' => [
          {
                'columns' => [
                  {
                        'entries' => [
                          {
                                'type' => 'text',
                                'text' => {
                                    'content' => 'A test',
                                },
                            },
                        ],
                    },
                ],
            },
        ],
    }

    @config["rows"].each do |row|
      some_columns_have_widths = row['columns'].select {|c| c['width']}.count > 0
      if some_columns_have_widths
        row['columns'] = row['columns'].map { |c| c['width'] ||=1; c }
        row['column_count'] = row['columns'].map { |c| c['width'] }.sum
      end
    end

    erb = File.read("#{Rails.root}/app/views/static/default_landing.html.erb")
    actual = ERB.new(erb).result(binding)

    expected_output = <<~HEREDOC
      <div class=\"Vlt-grid\"> <div class=\"row\"> <div class=\"Vlt-col\"> A test </div> </div> </div>
    HEREDOC

    # .squish() erb output to remove extranous newlines and whitespaces & .chomp trailing newline off expected_output
    expect(actual.squish).to eq(expected_output.chomp)
  end

  it 'renders two columns with 50% width each' do
    @config = {
        'rows' => [
          {
                'columns' => [
                  {
                        'width' => 1,
                        'entries' => [
                          {
                                'type' => 'text',
                                'text' => {
                                    'content' => 'Column 1',
                                },
                            },
                        ],
                    },
                  {
                        'width' => 1,
                        'entries' => [
                          {
                                'type' => 'text',
                                'text' => {
                                    'content' => 'Column 2',
                                },
                            },
                        ],

                  },
                ],
            },
        ],
    }

    @config["rows"].each do |row|
      some_columns_have_widths = row['columns'].select {|c| c['width']}.count > 0
      if some_columns_have_widths
        row['columns'] = row['columns'].map { |c| c['width'] ||=1; c }
        row['column_count'] = row['columns'].map { |c| c['width'] }.sum
      end
    end

    erb = File.read("#{Rails.root}/app/views/static/default_landing.html.erb")
    actual = ERB.new(erb).result(binding)

    expected_output = <<~HEREDOC
      <div class=\"Vlt-grid\"> <div class=\"row\"> <div class=\"Vlt-col--1of2\"> Column 1 </div> <div class=\"Vlt-col--1of2\"> Column 2 </div> </div> </div>
    HEREDOC

    # .squish() erb output to remove extranous newlines and whitespaces & .chomp trailing newline off expected_output
    expect(actual.squish).to eq(expected_output.chomp)
  end

  it 'renders three columns, no width specified' do
    @config = {
        'rows' => [
          {
                'columns' => [
                  {
                        'entries' => [
                          {
                                'type' => 'text',
                                'text' => {
                                    'content' => 'Column 1',
                                },
                            },
                        ],
                    },
                  {
                        'entries' => [
                          {
                                'type' => 'text',
                                'text' => {
                                    'content' => 'Column 2',
                                },
                            },
                        ],

                  },
                  {
                    'entries' => [
                      {
                            'type' => 'text',
                            'text' => {
                                'content' => 'Column 3',
                            },
                        },
                    ],

              },
                ],
            },
        ],
    }

    @config["rows"].each do |row|
      some_columns_have_widths = row['columns'].select {|c| c['width']}.count > 0
      if some_columns_have_widths
        row['columns'] = row['columns'].map { |c| c['width'] ||=1; c }
        row['column_count'] = row['columns'].map { |c| c['width'] }.sum
      end
    end

    erb = File.read("#{Rails.root}/app/views/static/default_landing.html.erb")
    actual = ERB.new(erb).result(binding)

    expected_output = <<~HEREDOC
      <div class=\"Vlt-grid\"> <div class=\"row\"> <div class=\"Vlt-col\"> Column 1 </div> <div class=\"Vlt-col\"> Column 2 </div> <div class=\"Vlt-col\"> Column 3 </div> </div> </div>
    HEREDOC

    # .squish() erb output to remove extranous newlines and whitespaces & .chomp trailing newline off expected_output
    expect(actual.squish).to eq(expected_output.chomp)
  end

  it 'renders two columns in three-column grid (1:2 and 1:1)' do
    @config = {
        'rows' => [
          {
                'columns' => [
                  {
                        'width' => 2,
                        'entries' => [
                          {
                                'type' => 'text',
                                'text' => {
                                    'content' => 'Column 1',
                                },
                            },
                        ],
                    },
                  {
                    'width' => 1,
                    'entries' => [
                      {
                            'type' => 'text',
                            'text' => {
                                'content' => 'Column 2',
                            },
                        },
                    ],

              },
                ],
            },
        ],
    }

    @config["rows"].each do |row|
      some_columns_have_widths = row['columns'].select {|c| c['width']}.count > 0
      if some_columns_have_widths
        row['columns'] = row['columns'].map { |c| c['width'] ||=1; c }
        row['column_count'] = row['columns'].map { |c| c['width'] }.sum
      end
    end

    erb = File.read("#{Rails.root}/app/views/static/default_landing.html.erb")
    actual = ERB.new(erb).result(binding)

    expected_output = <<~HEREDOC
      <div class=\"Vlt-grid\"> <div class=\"row\"> <div class=\"Vlt-col--2of3\"> Column 1 </div> <div class=\"Vlt-col--1of3\"> Column 2 </div> </div> </div>
    HEREDOC

    # .squish() erb output to remove extranous newlines and whitespaces & .chomp trailing newline off expected_output
    expect(actual.squish).to eq(expected_output.chomp)
  end

  it 'renders two columns in three-column grid (1:1 and 1:2)' do
    @config = {
        'rows' => [
          {
                'columns' => [
                  {
                        'width' => 1,
                        'entries' => [
                          {
                                'type' => 'text',
                                'text' => {
                                    'content' => 'Column 1',
                                },
                            },
                        ],
                    },
                  {
                    'width' => 2,
                    'entries' => [
                      {
                            'type' => 'text',
                            'text' => {
                                'content' => 'Column 2',
                            },
                        },
                    ],

              },
                ],
            },
        ],
    }

    @config["rows"].each do |row|
      some_columns_have_widths = row['columns'].select {|c| c['width']}.count > 0
      if some_columns_have_widths
        row['columns'] = row['columns'].map { |c| c['width'] ||=1; c }
        row['column_count'] = row['columns'].map { |c| c['width'] }.sum
      end
    end

    erb = File.read("#{Rails.root}/app/views/static/default_landing.html.erb")
    actual = ERB.new(erb).result(binding)

    expected_output = <<~HEREDOC
      <div class=\"Vlt-grid\"> <div class=\"row\"> <div class=\"Vlt-col--1of3\"> Column 1 </div> <div class=\"Vlt-col--2of3\"> Column 2 </div> </div> </div>
    HEREDOC

    # .squish() erb output to remove extranous newlines and whitespaces & .chomp trailing newline off expected_output
    expect(actual.squish).to eq(expected_output.chomp)
  end

  it 'renders two rows, one with two columns (1:1) and one with three (1:1:1)' do
    @config = {
      'rows' => [
        {
          'columns' => [
            {
              'width' => 1,
              'entries' => [],
            },
            {
              'width' => 1,
              'entries' => [],
            },
          ],
        },
        {
          'columns' => [
            {
              'width' => 1,
              'entries' => [],
            },
            {
              'width' => 1,
              'entries' => [],
            },
            {
              'width' => 1,
              'entries' => [],
            },
          ],
        },
      ],
    }

    @config["rows"].each do |row|
      some_columns_have_widths = row['columns'].select {|c| c['width']}.count > 0
      if some_columns_have_widths
        row['columns'] = row['columns'].map { |c| c['width'] ||=1; c }
        row['column_count'] = row['columns'].map { |c| c['width'] }.sum
      end
    end

    erb = File.read("#{Rails.root}/app/views/static/default_landing.html.erb")
    actual = ERB.new(erb).result(binding)

    expected_output = <<~HEREDOC
      <div class="Vlt-grid"> <div class="row"> <div class="Vlt-col--1of2"> </div> <div class="Vlt-col--1of2"> </div> </div> <div class="row"> <div class="Vlt-col--1of3"> </div> <div class="Vlt-col--1of3"> </div> <div class="Vlt-col--1of3"> </div> </div> </div>
    HEREDOC

    # .squish() erb output to remove extranous newlines and whitespaces & .chomp trailing newline off expected_output
    expect(actual.squish).to eq(expected_output.chomp)
  end

  it 'renders the correct grid size when the last item in the grid has no explicit width' do
    @config = {
      'rows' => [
        {
          'columns' => [
            {
              'width' => 1,
              'entries' => [],
            },
            {
              'entries' => [],
            },
          ],
        },
      ],
    }

    @config["rows"].each do |row|
      some_columns_have_widths = row['columns'].select {|c| c['width']}.count > 0
      if some_columns_have_widths
        row['columns'] = row['columns'].map { |c| c['width'] ||=1; c }
        row['column_count'] = row['columns'].map { |c| c['width'] }.sum
      end
    end

    erb = File.read("#{Rails.root}/app/views/static/default_landing.html.erb")
    actual = ERB.new(erb).result(binding)

    puts actual.squish
    expected_output = <<~HEREDOC
      <div class=\"Vlt-grid\"> <div class=\"row\"> <div class=\"Vlt-col--1of2\"> </div> <div class=\"Vlt-col--1of2\"> </div> </div> </div>
    HEREDOC

    # .squish() erb output to remove extranous newlines and whitespaces & .chomp trailing newline off expected_output
    expect(actual.squish).to eq(expected_output.chomp)
  end
end

# describe '/static/default_landing' do
#     it 'renders a single row with two columns and a default width' do

#         allow(LandingPageBlockRenderer::Text).to receive(:render).exactly(2).times and_return("")
#         allow(LandingPageBlockRenderer::JoinSlack).to receive(:render).once and_return("")
#         allow(LandingPageBlockRenderer::GithubRepo).to receive(:render).once and_return("")

#         receive().once
#         receive().twice
#         receive().exactly(3).times

#         page_config = {
#             "rows" => [
#                 {
#                     "columns" => [
#                         {
#                             "entries" => [
#                                 {
#                                     "type" => "text",
#                                     "text" => {
#                                         "content" => "This is a test"
#                                     }
#                                 },
#                                 {
#                                     "type" => "text",
#                                     "text" => {
#                                         "content" => "Another Text Block"
#                                     }
#                                 }
#                         ]
#                         },
#                         {
#                             "entries" => [
#                                 {
#                                     "type" => "join_slack"
#                                 },
#                                 {
#                                     "type" => "github_repo",
#                                     "github_repo" => {
#                                         "name" => "nexmo/nexmo-php"
#                                     }
#                                 }
#                             ]
#                         }
#                     ]
#                 }
#             ]
#         }

#         pageRenderer.render(page_config)
#     end

#     it 'renders a single row with two columns and a default width' do

#         allow(LandingPageBlockRenderer::Text).to receive(:render). and_return("")
#         allow(LandingPageBlockRenderer::JoinSlack).to receive(:render). and_return("")
#         allow(LandingPageBlockRenderer::GithubRepo).to receive(:render). and_return("")
#         page_config = {
#             "rows" => [
#                 {
#                     "columns" => [
#                         {
#                             "entries" => [{
#                                 "type" => "text",
#                                 "text" => {
#                                     "content" => "This is a test"
#                                 }
#                             }]
#                         },
#                         {
#                             "entries" => [
#                                 {
#                                     "type" => "join_slack"
#                                 },
#                                 {
#                                     "type" => "github_repo",
#                                     "github_repo" => {
#                                         "name" => "nexmo/nexmo-php"
#                                     }
#                                 }
#                             ]
#                         }
#                     ]
#                 }
#             ]
#         }

#         current = the current block being rendered
#         renderer = get_renderer(current['type'])
#         renderer.render(current)

#         TextBlockRenderer
#         JoinSlackBlockRenderer
#         GithubRepoBlockRenderer
#         HtmlBlockRenderer

#         erb = File.read("#{Rails.root}/app/views/static/default_landing.html.erb")
#         actual = ERB.new(erb).result(binding)

#         expected = <~~ HEREDOC
#         <div class="row">
#         <div class="column">
#         </div>
#         <div class="column">
#         </div>
#         </div>
#         HEREDOC
#     end
# end

# def get_renderer(type)
#     case type
#     when 'text'
#         LandingPageBlockRenderer::Text
#     when 'join_slack'
#         LandingPageBlockRenderer::JoinSlack
#     else
#       raise "Unknown block type: #{type}"
#     end
# end

# module LandingPageBlockRenderer
#     class Text
#         def self.render(params)
#             <~~HEREDOC
#             <p class="block-text">‹{params['text']['content']}</p>
#             HEREDOC
#         end
#     end
# end
