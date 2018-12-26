require 'rails_helper'

RSpec.describe ModalFilter do
  it 'takes input of title and markdown link and produces HTML content' do
    input = '@[Possible values](/_modals/api/developer/message/search/response/final-status.md)'

    expected_output = <<~HEREDOC
      <div class="Vlt-table Vlt-table--data Vlt-table--bordered"><table>
      <thead>
      <tr>
      <th>Value</th>
      <th>Description</th>
      </tr>
      </thead>
      <tbody>
      <tr>
      <td><code>DELIVRD</code></td>
      <td>This message has been delivered to the phone number.</td>
      </tr>
      <tr>
      <td><code>EXPIRED</code></td>
      <td>The target carrier did not send a status in the 48 hours after this message was delivered to them.</td>
      </tr>
      <tr>
      <td><code>UNDELIV</code></td>
      <td>The target carrier failed to deliver this message.</td>
      </tr>
      <tr>
      <td><code>REJECTD</code></td>
      <td>The target carrier rejected this message.</td>
      </tr>
      <tr>
      <td><code>UNKNOWN</code></td>
      <td>The target carrier has returned an undocumented status code.</td>
      </tr>
      </tbody>
      </table></div>
      </div>
    HEREDOC

    # using .include because the <a data-open='..'> tag changes each time it is executed
    expect(described_class.call(input)).to include(expected_output)
  end

  it 'does not transform text that does not match the regex' do
    input = 'some text'

    expected_output = 'some text'

    expect(described_class.call(input)).to eql(expected_output)
  end

  it 'does not transform an argument of only a whitespace' do
    input = ' '

    expected_output = ' '

    expect(described_class.call(input)).to eql(expected_output)
  end
end
