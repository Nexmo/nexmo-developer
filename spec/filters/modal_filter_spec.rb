require 'rails_helper'

RSpec.describe ModalFilter do
  it 'takes input of title and markdown link and produces HTML content' do
    allow(SecureRandom).to receive(:hex).and_return('12345')
    input = '@[Possible values](_modals/api/developer/message/search/response/final-status.md)'

    expected_output = "<a href='javascript:void(0)' data-modal='M12345' class='Vlt-modal-trigger Vlt-text-link'>Possible values</a>FREEZESTARTPGRpdiBjbGFzcz0iVmx0LW1vZGFsIiBpZD0iTTEyMzQ1Ij4KICA8ZGl2IGNsYXNzPSJWbHQtbW9kYWxfX3BhbmVsIj4KICAgIDxkaXYgY2xhc3M9IlZsdC1tb2RhbF9fY29udGVudCI-CiAgPGRpdiBjbGFzcz0iVmx0LXRhYmxlIFZsdC10YWJsZS0tZGF0YSBWbHQtdGFibGUtLWJvcmRlcmVkIj48dGFibGU-Cjx0aGVhZD4KPHRyPgo8dGg-VmFsdWU8L3RoPgo8dGg-RGVzY3JpcHRpb248L3RoPgo8L3RyPgo8L3RoZWFkPgo8dGJvZHk-Cjx0cj4KPHRkPjxjb2RlPkRFTElWUkQ8L2NvZGU-PC90ZD4KPHRkPlRoaXMgbWVzc2FnZSBoYXMgYmVlbiBkZWxpdmVyZWQgdG8gdGhlIHBob25lIG51bWJlci48L3RkPgo8L3RyPgo8dHI-Cjx0ZD48Y29kZT5FWFBJUkVEPC9jb2RlPjwvdGQ-Cjx0ZD5UaGUgdGFyZ2V0IGNhcnJpZXIgZGlkIG5vdCBzZW5kIGEgc3RhdHVzIGluIHRoZSA0OCBob3VycyBhZnRlciB0aGlzIG1lc3NhZ2Ugd2FzIGRlbGl2ZXJlZCB0byB0aGVtLjwvdGQ-CjwvdHI-Cjx0cj4KPHRkPjxjb2RlPlVOREVMSVY8L2NvZGU-PC90ZD4KPHRkPlRoZSB0YXJnZXQgY2FycmllciBmYWlsZWQgdG8gZGVsaXZlciB0aGlzIG1lc3NhZ2UuPC90ZD4KPC90cj4KPHRyPgo8dGQ-PGNvZGU-UkVKRUNURDwvY29kZT48L3RkPgo8dGQ-VGhlIHRhcmdldCBjYXJyaWVyIHJlamVjdGVkIHRoaXMgbWVzc2FnZS48L3RkPgo8L3RyPgo8dHI-Cjx0ZD48Y29kZT5VTktOT1dOPC9jb2RlPjwvdGQ-Cjx0ZD5UaGUgdGFyZ2V0IGNhcnJpZXIgaGFzIHJldHVybmVkIGFuIHVuZG9jdW1lbnRlZCBzdGF0dXMgY29kZS48L3RkPgo8L3RyPgo8L3Rib2R5Pgo8L3RhYmxlPjwvZGl2PgogICAgPC9kaXY-CiAgPC9kaXY-CjwvZGl2Pgo=FREEZEEND"

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
