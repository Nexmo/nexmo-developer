require 'rails_helper'

RSpec.describe ModalFilter do
  it 'takes input of title and markdown link and produces HTML content' do
    allow(SecureRandom).to receive(:uuid).and_return('12345')
    input = '@[Possible values](/_modals/api/developer/message/search/response/final-status.md)'

    expected_output = "<a data-open='12345'>Possible values</a>FREEZESTARTPGRpdiBjbGFzcz0icmV2ZWFsIiBpZD0iMTIzNDUiIGRhdGEtcmV2ZWFsPgogIDxkaXYgY2xhc3M9IlZsdC10YWJsZSBWbHQtdGFibGUtLWRhdGEgVmx0LXRhYmxlLS1ib3JkZXJlZCI-PHRhYmxlPgo8dGhlYWQ-Cjx0cj4KPHRoPlZhbHVlPC90aD4KPHRoPkRlc2NyaXB0aW9uPC90aD4KPC90cj4KPC90aGVhZD4KPHRib2R5Pgo8dHI-Cjx0ZD48Y29kZT5ERUxJVlJEPC9jb2RlPjwvdGQ-Cjx0ZD5UaGlzIG1lc3NhZ2UgaGFzIGJlZW4gZGVsaXZlcmVkIHRvIHRoZSBwaG9uZSBudW1iZXIuPC90ZD4KPC90cj4KPHRyPgo8dGQ-PGNvZGU-RVhQSVJFRDwvY29kZT48L3RkPgo8dGQ-VGhlIHRhcmdldCBjYXJyaWVyIGRpZCBub3Qgc2VuZCBhIHN0YXR1cyBpbiB0aGUgNDggaG91cnMgYWZ0ZXIgdGhpcyBtZXNzYWdlIHdhcyBkZWxpdmVyZWQgdG8gdGhlbS48L3RkPgo8L3RyPgo8dHI-Cjx0ZD48Y29kZT5VTkRFTElWPC9jb2RlPjwvdGQ-Cjx0ZD5UaGUgdGFyZ2V0IGNhcnJpZXIgZmFpbGVkIHRvIGRlbGl2ZXIgdGhpcyBtZXNzYWdlLjwvdGQ-CjwvdHI-Cjx0cj4KPHRkPjxjb2RlPlJFSkVDVEQ8L2NvZGU-PC90ZD4KPHRkPlRoZSB0YXJnZXQgY2FycmllciByZWplY3RlZCB0aGlzIG1lc3NhZ2UuPC90ZD4KPC90cj4KPHRyPgo8dGQ-PGNvZGU-VU5LTk9XTjwvY29kZT48L3RkPgo8dGQ-VGhlIHRhcmdldCBjYXJyaWVyIGhhcyByZXR1cm5lZCBhbiB1bmRvY3VtZW50ZWQgc3RhdHVzIGNvZGUuPC90ZD4KPC90cj4KPC90Ym9keT4KPC90YWJsZT48L2Rpdj4KPC9kaXY-Cg==FREEZEEND"

    expect(described_class.call(input)).to eq(expected_output)
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
