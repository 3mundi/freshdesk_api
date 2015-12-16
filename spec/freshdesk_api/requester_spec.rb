module FreshdeskAPI
  describe Requester do
    # https://pathtravel.freshdesk.com/helpdesk/tickets.json
    describe 'instance' do
      subject { described_class.new(Tickets.new) }
      xit { expect(subject.url).to eq 'https://pathtravel.freshdesk.com/helpdesk/tickets.json' }
    end
  end
end
