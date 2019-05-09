require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '#load' do
    it 'returns a single task' do
      create_example_config
      task = described_class.load('example-task', 'introduction')

      expect(task).to be_kind_of(Task)
      expect(task.title).to eq('This is an example task')
      expect(task.description).to eq('Welcome to an amazing description')
      expect(task.product).to eq('demo-product')
      expect(task.subtasks).to eq([application_subtask, outbound_call_subtask])
    end

    it 'returns a task with an introduction' do
      create_example_config(true, false)
      task = described_class.load('example-task', 'introduction')
      expect(task.subtasks).to eq([
                                    introduction_subtask,
                                    application_subtask,
                                    outbound_call_subtask,
                                  ])
    end

    it 'returns a task with an introduction' do
      create_example_config(false, true)
      task = described_class.load('example-task', 'introduction')
      expect(task.subtasks).to eq([
                                    application_subtask,
                                    outbound_call_subtask,
                                    conclusion_subtask,
                                  ])
    end

    it 'returns a task with an introduction and a conclusion' do
      create_example_config(true, true)
      task = described_class.load('example-task', 'introduction')
      expect(task.subtasks).to eq([
                                    introduction_subtask,
                                    application_subtask,
                                    outbound_call_subtask,
                                    conclusion_subtask,
                                  ])
    end

    it 'returns a task with an introduction and a conclusion but no tasks' do
      config = {
        'title' => 'No tasks',
        'description' => 'Description here',
        'product' => 'demo',
      }
      allow(File).to receive(:read).with("#{Task.task_config_path}/example-task.yml") .and_return(config.to_yaml)

      task = described_class.load('example-task', 'introduction')
      expect(task.subtasks).to eq([])
    end
  end

  describe '#next_step' do
    it 'returns nil if there is no next step' do
      create_example_config(true, true)
      task = described_class.load('example-task', 'conclusion')
      expect(task.next_step).to be_nil
    end

    it 'returns the next step after an introduction' do
      create_example_config(true, true)
      task = described_class.load('example-task', 'introduction')
      expect(task.next_step).to eq(application_subtask)
    end

    it 'returns the next step after a task' do
      create_example_config(true, true)
      task = described_class.load('example-task', 'application/create-voice')
      expect(task.next_step).to eq(outbound_call_subtask)
    end
  end

  describe '#previous_step' do
    it 'returns nil if there is no previous step' do
      create_example_config(true, true)
      task = described_class.load('example-task', 'introduction')
      expect(task.previous_step).to be_nil
    end

    it 'returns the previous step before a conclusion' do
      create_example_config(true, true)
      task = described_class.load('example-task', 'conclusion')
      expect(task.previous_step).to eq(outbound_call_subtask)
    end

    it 'returns the previous step before a task' do
      create_example_config(true, true)
      task = described_class.load('example-task', 'voice/make-outbound-call')
      expect(task.previous_step).to eq(application_subtask)
    end
  end

  describe '#first_step' do
    it 'returns introduction if it exists' do
      create_example_config(true, false)
      task = described_class.load('example-task', 'introduction')
      expect(task.first_step).to eq('introduction')
    end

    it 'returns the first step if there is no introduction' do
      create_example_config(false, false)
      task = described_class.load('example-task', 'introduction')
      expect(task.first_step).to eq('application/create-voice')
    end
  end

  describe '#content_for' do
    context 'introduction' do
      it 'returns content if it exists' do
        create_example_config(true, false)
        task = described_class.load('example-task', 'introduction')
        expect(task.content_for('introduction')).to eq('Start of a task')
      end

      it 'raises if it does not exist' do
        create_example_config(false, false)
        task = described_class.load('example-task', 'introduction')
        expect { task.content_for('introduction') }.to raise_error('Invalid step: introduction')
      end
    end

    context 'conclusion' do
      it 'returns content if it exists' do
        create_example_config(false, true)
        task = described_class.load('example-task', 'introduction')
        expect(task.content_for('conclusion')).to eq('End of a task')
      end

      it 'raises if it does not exist' do
        create_example_config(false, false)
        task = described_class.load('example-task', 'introduction')
        expect { task.content_for('conclusion') }.to raise_error('Invalid step: conclusion')
      end
    end

    context 'dynamic step' do
      it 'returns content if it exists' do
        create_example_config(false, false)
        task = described_class.load('example-task', 'introduction')
        expect(task.content_for('application/create-voice')).to eq(<<~HEREDOC
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
        allow(File).to receive(:exist?).with("#{Task.task_content_path}/missing-step.md") .and_return(false)
        create_example_config(false, false)
        task = described_class.load('example-task', 'introduction')
        expect { task.content_for('missing-step') }.to raise_error('Invalid step: missing-step')
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
  stub_task_config(
    path: "#{Task.task_config_path}/example-task.yml",
    title: 'This is an example task',
    description: 'Welcome to an amazing description',
    product: 'demo-product',
    tasks: ['application/create-voice', 'voice/make-outbound-call'],
    include_introduction: intro,
    include_conclusion: conclusion
  )

  create_application_content
  create_outbound_call_content
end

def stub_task_config(path:, title:, description:, product:, tasks:, include_introduction:, include_conclusion:) # rubocop:disable Metrics/ParameterLists
  config = {
    'title' => title,
    'description' => description,
    'product' => product,
    'is_active' => false,
    'tasks' => tasks,
  }

  if include_introduction
    config['introduction'] = {
      'title' => 'Introduction Title',
      'description' => 'This is an introduction',
      'is_active' => true,
      'content' => 'Start of a task',
    }
  end

  if include_conclusion
    config['conclusion'] = {
      'title' => 'Conclusion Title',
      'description' => 'This is a conclusion',
      'is_active' => false,
      'content' => 'End of a task',
    }
  end

  allow(File).to receive(:read).with(path) .and_return(config.to_yaml)
end

def create_application_content
  stub_task_content(
    path: "#{Task.task_content_path}/application/create-voice.md",
    title: 'Create a voice application',
    description: 'Learn how to create a voice application',
    content: <<~HEREDOC
      # Create a voice application
      Creating a voice application is very important. Please do it
    HEREDOC
  )
end

def create_outbound_call_content
  stub_task_content(
    path: "#{Task.task_content_path}/voice/make-outbound-call.md",
    title: 'Make an outbound call',
    description: 'Simple outbound call example',
    content: <<~HEREDOC
      # Make an outbound call
      This is an example outbound call with Text-To-Speech
    HEREDOC
  )
end

def stub_task_content(path:, title:, description:, content:)
  allow(File).to receive(:exist?).with(path) .and_return(true)
  allow(File).to receive(:read).with(path) .and_return({
    'title' => title,
    'description' => description,
  }.to_yaml + "---\n" + content)
end
