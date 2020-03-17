require 'rails_helper'

RSpec.shared_examples 'renders the corresponding layout' do |matches|
  it do
    get '/default_landing'

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
end

RSpec.describe StaticController, type: :request do
  describe 'GET default_landing' do
    before do
      Rails.application.routes.draw do
        get '(/:locale)/documentation', to: 'static#documentation', as: :documentation
        get '/use-cases', to: 'use_case#index', as: :use_cases
        get '/careers', to: 'careers#index', as: :careers
        get '(/:locale)/api', to: 'api#index', as: :api
        get '/extend', to: 'extend#index', as: :extend
        get '/tools', to: 'static#tools', as: :tools
        get '/:landing_page' => 'static#default_landing', as: :static
      end

      expect(YAML).to receive(:load_file).with("#{Rails.root}/config/landing_pages/default_landing.yml").and_return(config)
      allow(YAML).to receive(:load_file).and_call_original
    end

    after do
      Rails.application.reload_routes!
    end

    context 'renders single column with 100% width' do
      let(:config) do
        {
          'page' => [
            {
                'row' => [
                  {
                        'column' => [
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
      end
      it_behaves_like 'renders the corresponding layout', [['Vlt-col']]
    end

    context 'renders two columns with 50% width each' do
      let(:config) do
        {
          'page' => [
            {
              'row' => [
                {
                  'width' => 1,
                  'column' => [
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
                  'column' => [
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
      end

      it_behaves_like 'renders the corresponding layout', [['Vlt-col--1of2', 'Vlt-col--1of2']]
    end

    context 'renders three columns, no width specified' do
      let(:config) do
        {
          'page' => [
            {
              'row' => [
                {
                  'column' => [
                    {
                      'type' => 'text',
                      'text' => {
                        'content' => 'Column 1',
                      },
                    },
                  ],
                },
                {
                  'column' => [
                    {
                      'type' => 'text',
                      'text' => {
                        'content' => 'Column 2',
                      },
                    },
                  ],

                },
                {
                  'column' => [
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
      end

      it_behaves_like 'renders the corresponding layout', [['Vlt-col', 'Vlt-col', 'Vlt-col']]
    end

    context 'renders two columns in three-column grid (1:2 and 1:1)' do
      let(:config) do
        {
          'page' => [
            {
              'row' => [
                {
                  'width' => 2,
                  'column' => [
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
                  'column' => [
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
      end

      it_behaves_like 'renders the corresponding layout', [['Vlt-col--2of3', 'Vlt-col--1of3']]
    end

    context 'renders two columns in three-column grid (1:1 and 1:2)' do
      let(:config) do
        {
          'page' => [
            {
              'row' => [
                {
                  'width' => 1,
                  'column' => [
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
                  'column' => [
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
      end

      it_behaves_like 'renders the corresponding layout', [['Vlt-col--1of3', 'Vlt-col--2of3']]
    end

    context 'renders two rows, one with two columns (1:1) and one with three (1:1:1)' do
      let(:config) do
        {
          'page' => [
            {
              'row' => [
                {
                  'width' => 1,
                  'column' => [],
                },
                {
                  'width' => 1,
                  'column' => [],
                },
              ],
            },
            {
              'row' => [
                {
                  'width' => 1,
                  'column' => [],
                },
                {
                  'width' => 1,
                  'column' => [],
                },
                {
                  'width' => 1,
                  'column' => [],
                },
              ],
            },
          ],
        }
      end

      it_behaves_like 'renders the corresponding layout', [['Vlt-col--1of2', 'Vlt-col--1of2'], ['Vlt-col--1of3', 'Vlt-col--1of3', 'Vlt-col--1of3']]
    end

    context 'renders the correct grid size when the last item in the grid has no explicit width' do
      let(:config) do
        {
          'page' => [
            {
              'row' => [
                {
                  'width' => 1,
                  'column' => [],
                },
                {
                  'column' => [],
                },
              ],
            },
          ],
        }
      end

      it_behaves_like 'renders the corresponding layout', [['Vlt-col--1of2', 'Vlt-col--1of2']]
    end

    context 'renders the correct grid size when the first item in the grid has no explicit width' do
      let(:config) do
        {
          'page' => [
            {
              'row' => [
                {
                  'column' => [],
                },
                {
                  'width' => 1,
                  'column' => [],
                },
              ],
            },
          ],
        }
      end

      it_behaves_like 'renders the corresponding layout', [['Vlt-col--1of2', 'Vlt-col--1of2']]
    end
  end
end
