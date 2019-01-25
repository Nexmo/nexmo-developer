require 'rails_helper'

RSpec.describe StaticController, type: :controller do
  before do
    Rails.application.routes.draw do
      get '/default_landing' => 'static#default_landing'
    end
  end
  after do
    Rails.application.reload_routes!
  end

  describe 'GET default_landing' do
    render_views

    it 'renders single column with 100% width' do
      landing_config = {
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

      assert_rows_and_columns(
        landing_config,
        [
          ['Vlt-col'],
        ]
      )
    end

    it 'renders two columns with 50% width each' do
      landing_config = {
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
      assert_rows_and_columns(
        landing_config,
        [
          ['Vlt-col--1of2', 'Vlt-col--1of2'],
        ]
      )
    end

    it 'renders three columns, no width specified' do
      landing_config = {
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
      assert_rows_and_columns(
        landing_config,
        [
          ['Vlt-col', 'Vlt-col', 'Vlt-col'],
        ]
      )
    end

    it 'renders two columns in three-column grid (1:2 and 1:1)' do
      landing_config = {
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

      assert_rows_and_columns(
        landing_config,
        [
          ['Vlt-col--2of3', 'Vlt-col--1of3'],
        ]
      )
    end

    it 'renders two columns in three-column grid (1:1 and 1:2)' do
      landing_config = {
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
      assert_rows_and_columns(
        landing_config,
        [
          ['Vlt-col--1of3', 'Vlt-col--2of3'],
        ]
      )
    end

    it 'renders two rows, one with two columns (1:1) and one with three (1:1:1)' do
      landing_config = {
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
      assert_rows_and_columns(
        landing_config,
        [
          ['Vlt-col--1of2', 'Vlt-col--1of2'],
          ['Vlt-col--1of3', 'Vlt-col--1of3', 'Vlt-col--1of3'],
        ]
      )
    end

    it 'renders the correct grid size when the last item in the grid has no explicit width' do
      landing_config = {
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
      assert_rows_and_columns(
        landing_config,
        [
          ['Vlt-col--1of2', 'Vlt-col--1of2'],
        ]
      )
    end

    it 'renders the correct grid size when the first item in the grid has no explicit width' do
      landing_config = {
        'rows' => [
          {
            'columns' => [
              {
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
      assert_rows_and_columns(
        landing_config,
        [
          ['Vlt-col--1of2', 'Vlt-col--1of2'],
        ]
      )
    end
  end
end

def assert_rows_and_columns(config, matches)
  expect(YAML).to receive(:load_file).with("#{Rails.root}/config/landing_pages/default_landing.yml") .and_return(config)
  allow(YAML).to receive(:load_file)

  get :default_landing

  assert_select '.Nxd-landing-page' do |elements|
    assert_select elements[0], '.Nxd-landing-row', matches.count do |rows|
      rows.each_with_index do |row, i|
        row_match = matches[i]
        cols = css_select row, '.Nxd-landing-col'
        cols.each_with_index do |col, index|
          expect(col['class']).to include(row_match[index])
        end
      end
    end
  end
end
