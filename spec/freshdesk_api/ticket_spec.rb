require 'spec_helper'
module FreshdeskAPI
  describe Ticket do
    let(:ticket_number) { 15 }
    xit { expect(described_class.resource).to eq 'tickets' }
    xit { expect(described_class.for_url).to eq 'tickets' }
    describe '::index' do
      let(:index_request) do
        VCR.use_cassette('tickets_index') do
          described_class.index
        end
      end
      it { expect(index_request).to be_a Array }
      describe 'First' do
        subject{ index_request.first }
        its(:display_id) { is_expected.to eq 14 }
        its(:status) { is_expected.to eq 2 }
        its(:subject) { is_expected.to eq "Support needed.." }
      end
    end

    describe '::create' do
      let(:params) do
        {
          description:"Some details on the issue ...",
          subject:"Support needed..",
          email:"apanach@path.travel",
          priority: 1,
          status: 2
        }
      end
      subject(:create_request) do
        VCR.use_cassette('tickets_post_from_ticket_resource') do
          described_class.create(params)
        end
      end
      its(:status) { is_expected.to eq 2 }
      its(:display_id) { is_expected.to eq 16 }
      its(:id) { is_expected.to eq 9000712980 }
      its(:description) { is_expected.to match 'Some details on the issue' }
    end

    describe '::show' do
      subject(:show_request) do
        VCR.use_cassette('tickets_show') do
          described_class.show(ticket_number)
        end
      end
      its(:status) { is_expected.to eq 5 }
      its(:display_id) { is_expected.to eq 15 }
      its(:id) { is_expected.to eq 9000698855 }
      its(:description) { is_expected.to match 'Some details on the issue' }
      describe '#notes' do
        subject { show_request.notes.first }
        its(:body) { is_expected.to eq "created_by: 9005888574\ntime: 2015-12-16 12:38:35 -0500" }
        its(:body_html) { is_expected.to eq "<div>created_by: 9005888574<br>time: 2015-12-16 12:38:35 -0500</div>" }
        its(:created_at) { is_expected.to eq "2015-12-16T12:38:35-05:00" }
        its(:deleted) { is_expected.to eq false }
        its(:id) { is_expected.to eq 9000674146 }
        its(:incoming) { is_expected.to eq false }
        its(:private) { is_expected.to eq true }
        its(:source) { is_expected.to eq 4 }
        its(:updated_at) { is_expected.to eq "2015-12-16T12:38:35-05:00" }
        its(:user_id) { is_expected.to eq 9005941712 }
        its(:attachments) { is_expected.to eq [] }
        its(:support_email) { is_expected.to eq nil }
      end
      context 'When ticket does not exists' do
        subject(:show_request) do
          VCR.use_cassette('tickets/show/90') do
            described_class.show(90)
          end
        end
        it { is_expected.to be_nil }
      end
    end
    describe '::update' do
      let(:params) do
        {
          status: 5
        }
      end
      subject(:update_request) do
        VCR.use_cassette('tickets_update_from_ticket_resource') do
          described_class.update(16, params)
        end
      end
      its(:status_name) { is_expected.to eq 'Closed' }
      its(:status) { is_expected.to eq 5 }
      its(:requester_status_name) { is_expected.to eq "This ticket has been Closed" }
      its(:priority_name) { is_expected.to eq "Low" }
      its(:priority) { is_expected.to eq 1 }
      its(:source_name) { is_expected.to eq "Portal" }
      its(:source) { is_expected.to eq 2 }
      its(:requester_name) { is_expected.to eq "Apanach" }
      its(:responder_name) { is_expected.to eq "No Agent" }
      its(:display_id) { is_expected.to eq 16 }
    end
    describe '::destroy' do
      let(:update_request) do
        VCR.use_cassette('tickets_destroy') do
          described_class.destroy(ticket_number)
        end
      end
      it { expect(update_request).to eq true }
    end

    describe '::add_note' do
      subject(:add_note_req) do
        VCR.use_cassette('tickets_add_note_from_tickets_resource') do
          described_class.add_note(17,
            body: 'Hi Mum',
            private: false
          )
        end
      end
      its(:body) { is_expected.to eq 'Hi Mum' }
    end
    describe 'instance' do
      subject { described_class.new }
      # it { expect(subject.resource).to eq 'tickets' }
      # it { expect(subject.for_url).to eq 'tickets' }
    end
  end
end
