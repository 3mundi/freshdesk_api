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
      it 'status' do
        expect(index_request.status).to eq 200
      end
      it 'body' do
        expect(index_request.body).to be_a Array
      end
    end

    describe '::create' do
      let(:params) do
        {
          helpdesk_ticket:{
              description:"Some details on the issue ...",
              subject:"Support needed..",
              email:"apanach@path.travel",
              priority: 1,
              status: 2
          }
        }
      end
      let(:create_request) do
        VCR.use_cassette('tickets_post') do
          described_class.create(params)
        end
      end
      it 'status' do
        expect(create_request.status).to eq 200
      end
      it 'body' do
        expect(create_request.body).to be_a Hash
      end
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
    end
    describe '::update' do
      let(:params) do
        {
          helpdesk_ticket: {
            status: 5
          }
        }
      end
      let(:update_request) do
        VCR.use_cassette('tickets_update') do
          described_class.update(ticket_number, params)
        end
      end
      it 'status' do
        expect(update_request.status).to eq 200
      end
      it 'body' do
        expect(update_request.body).to be_a Hash
      end
    end
    describe '::destroy' do
      let(:update_request) do
        VCR.use_cassette('tickets_destroy') do
          described_class.destroy(ticket_number)
        end
      end
      it 'status' do
        expect(update_request.status).to eq 200
      end
      it 'body' do
        expect(update_request.body.to_s).to match 'deleted'
      end
    end
    describe 'instance' do
      subject { described_class.new }
      # it { expect(subject.resource).to eq 'tickets' }
      # it { expect(subject.for_url).to eq 'tickets' }
    end
  end
end
