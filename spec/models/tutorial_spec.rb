require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe '#load' do
    it 'returns a single tutorial' do
      create_example_config
      tutorial = described_class.load('example-tutorial', 'introduction')

      expect(tutorial).to be_kind_of(Tutorial)
      expect(tutorial.title).to eq('This is an example tutorial')
      expect(tutorial.description).to eq('Welcome to an amazing description')
      expect(tutorial.products).to eq(['demo-product'])
      expect(tutorial.subtasks).to eq([application_subtask, outbound_call_subtask])
    end

    it 'returns a tutorial with an introduction' do
      create_example_config(true, false)
      tutorial = described_class.load('example-tutorial', 'introduction')
      expect(tutorial.subtasks).to eq([
                                        introduction_subtask,
                                        application_subtask,
                                        outbound_call_subtask,
                                      ])
    end

    it 'returns a tutorial with an introduction' do
      create_example_config(false, true)
      tutorial = described_class.load('example-tutorial', 'introduction')
      expect(tutorial.subtasks).to eq([
                                        application_subtask,
                                        outbound_call_subtask,
                                        conclusion_subtask,
                                      ])
    end

    it 'returns a tutorial with an introduction and a conclusion' do
      create_example_config(true, true)
      tutorial = described_class.load('example-tutorial', 'introduction')
      expect(tutorial.subtasks).to eq([
                                        introduction_subtask,
                                        application_subtask,
                                        outbound_call_subtask,
                                        conclusion_subtask,
                                      ])
    end

    it 'returns a tutorial with an introduction and a conclusion but no tutorials' do
      path = 'config/tutorials/en/example-tutorial.yml'
      config = {
        'title' => 'No tutorials',
        'description' => 'Description here',
        'products' => ['demo'],
      }
      expect(DocFinder).to receive(:find)
        .with(root: 'config/tutorials', document: 'example-tutorial', language: :en, format: 'yml')
        .and_return(path)
      expect(File).to receive(:read).with(path).and_return(config.to_yaml)

      tutorial = described_class.load('example-tutorial', 'introduction')
      expect(tutorial.subtasks).to eq([])
    end
  end

  describe '#current_product' do
    it 'respects the product if provided' do
      create_example_config
      tutorial = described_class.load('example-tutorial', 'introduction', 'banana')
      expect(tutorial.current_product).to eq('banana')
    end

    it 'defaults to the first item in the products list if not provided' do
      create_example_config
      tutorial = described_class.load('example-tutorial', 'introduction')
      expect(tutorial.current_product).to eq('demo-product')
    end
  end

  describe '#next_step' do
    it 'returns nil if there is no next step' do
      create_example_config(true, true)
      tutorial = described_class.load('example-tutorial', 'conclusion')
      expect(tutorial.next_step).to be_nil
    end

    it 'returns the next step after an introduction' do
      create_example_config(true, true)
      tutorial = described_class.load('example-tutorial', 'introduction')
      expect(tutorial.next_step).to eq(application_subtask)
    end

    it 'returns the next step after a tutorial' do
      create_example_config(true, true)
      tutorial = described_class.load('example-tutorial', 'application/create-voice')
      expect(tutorial.next_step).to eq(outbound_call_subtask)
    end
  end

  describe '#previous_step' do
    it 'returns nil if there is no previous step' do
      create_example_config(true, true)
      tutorial = described_class.load('example-tutorial', 'introduction')
      expect(tutorial.previous_step).to be_nil
    end

    it 'returns the previous step before a conclusion' do
      create_example_config(true, true)
      tutorial = described_class.load('example-tutorial', 'conclusion')
      expect(tutorial.previous_step).to eq(outbound_call_subtask)
    end

    it 'returns the previous step before a tutorial' do
      create_example_config(true, true)
      tutorial = described_class.load('example-tutorial', 'voice/make-outbound-call')
      expect(tutorial.previous_step).to eq(application_subtask)
    end
  end

  describe '#first_step' do
    it 'returns introduction if it exists' do
      create_example_config(true, false)
      tutorial = described_class.load('example-tutorial', 'introduction')
      expect(tutorial.first_step).to eq('introduction')
    end

    it 'returns the first step if there is no introduction' do
      create_example_config(false, false)
      tutorial = described_class.load('example-tutorial', 'introduction')
      expect(tutorial.first_step).to eq('application/create-voice')
    end
  end

  describe '#content_for' do
    context 'introduction' do
      it 'returns content if it exists' do
        create_example_config(true, false)
        tutorial = described_class.load('example-tutorial', 'introduction')
        expect(tutorial.content_for('introduction')).to eq('Start of a tutorial')
      end

      it 'raises if it does not exist' do
        create_example_config(false, false)
        tutorial = described_class.load('example-tutorial', 'introduction')
        expect { tutorial.content_for('introduction') }.to raise_error('Invalid step: introduction')
      end
    end

    context 'conclusion' do
      it 'returns content if it exists' do
        create_example_config(false, true)
        tutorial = described_class.load('example-tutorial', 'introduction')
        expect(tutorial.content_for('conclusion')).to eq('End of a tutorial')
      end

      it 'raises if it does not exist' do
        create_example_config(false, false)
        tutorial = described_class.load('example-tutorial', 'introduction')
        expect { tutorial.content_for('conclusion') }.to raise_error('Invalid step: conclusion')
      end
    end

    context 'dynamic step' do
      it 'returns content if it exists' do
        create_example_config(false, false)
        tutorial = described_class.load('example-tutorial', 'introduction')
        expect(tutorial.content_for('application/create-voice')).to eq(<<~HEREDOC
          ---
          title: Create a voice application
          description: Learn how to create a voice application
          ---
          # Create a voice application
          Creating a voice application is very important. Please do it
        HEREDOC
                                                                   .strip + "\n")
      end

      it 'raises if it does not exist' do
        create_example_config
        tutorial = described_class.load('example-tutorial', 'introduction')
        expect(DocFinder).to receive(:find).with(root: '_tutorials', document: 'missing-step', language: :en).and_call_original
        expect { tutorial.content_for('missing-step') }.to raise_error(DocFinder::MissingDoc)
      end
    end
  end
end

def introduction_subtask
  { 'path' => 'introduction',
    'title' => 'Introduction Title',
    'is_active' => true,
    'description' => 'This is an introduction' }
end

def application_subtask
  { 'path' => 'application/create-voice',
    'title' => 'Create a voice application',
    'is_active' => false,
    'description' => 'Learn how to create a voice application' }
end

def outbound_call_subtask
  { 'path' => 'voice/make-outbound-call',
    'title' => 'Make an outbound call',
    'is_active' => false,
    'description' => 'Simple outbound call example' }
end

def conclusion_subtask
  { 'path' => 'conclusion',
    'title' => 'Conclusion Title',
    'is_active' => false,
    'description' => 'This is a conclusion' }
end

def create_example_config(intro = false, conclusion = false)
  path = 'config/tutorials/en/example-tutorial.yml'
  stub_task_config(
    path: path,
    title: 'This is an example tutorial',
    description: 'Welcome to an amazing description',
    products: ['demo-product'],
    tasks: ['application/create-voice', 'voice/make-outbound-call'],
    include_introduction: intro,
    include_conclusion: conclusion
  )
  allow(DocFinder).to receive(:find)
    .with(root: 'config/tutorials', document: 'example-tutorial', language: :en, format: 'yml')
    .and_return(path)

  create_application_content
  create_outbound_call_content
end

def stub_task_config(path:, title:, description:, products:, tasks:, include_introduction:, include_conclusion:) # rubocop:disable Metrics/ParameterLists
  config = {
    'title' => title,
    'description' => description,
    'products' => products,
    'is_active' => false,
    'tasks' => tasks,
  }

  if include_introduction
    config['introduction'] = {
      'title' => 'Introduction Title',
      'description' => 'This is an introduction',
      'is_active' => true,
      'content' => 'Start of a tutorial',
    }
  end

  if include_conclusion
    config['conclusion'] = {
      'title' => 'Conclusion Title',
      'description' => 'This is a conclusion',
      'is_active' => false,
      'content' => 'End of a tutorial',
    }
  end

  allow(File).to receive(:read).with(path).and_return(config.to_yaml)
end

def create_application_content
  path = "#{Tutorial.task_content_path}/en/application/create-voice.md"
  stub_task_content(
    path: path,
    title: 'Create a voice application',
    description: 'Learn how to create a voice application',
    content: <<~HEREDOC
      # Create a voice application
      Creating a voice application is very important. Please do it
    HEREDOC
  )
  allow(DocFinder).to receive(:find)
    .with(root: '_tutorials', document: 'application/create-voice', language: :en)
    .and_return(path)
end

def create_outbound_call_content
  path = "#{Tutorial.task_content_path}/en/voice/make-outbound-call.md"
  stub_task_content(
    path: path,
    title: 'Make an outbound call',
    description: 'Simple outbound call example',
    content: <<~HEREDOC
      # Make an outbound call
      This is an example outbound call with Text-To-Speech
    HEREDOC
  )
  allow(DocFinder).to receive(:find)
    .with(root: '_tutorials', document: 'voice/make-outbound-call', language: :en)
    .and_return(path)
end

def stub_task_content(path:, title:, description:, content:)
  allow(File).to receive(:exist?).with(path).and_return(true)
  allow(File).to receive(:read).with(path).and_return({
    'title' => title,
    'description' => description,
  }.to_yaml + "---\n" + content)
end
