require 'spec_helper'
module FreshdeskAPI
  describe Tickets do
    let(:ticket_number) { 15 }
    it { expect(described_class.resource).to eq 'tickets' }
    it { expect(described_class.for_url).to eq 'tickets' }
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
      let(:show_request) do
        VCR.use_cassette('tickets_show') do
          described_class.show(ticket_number)
        end
      end
      it 'status' do
        expect(show_request.status).to eq 200
      end
      it 'body' do
        expect(show_request.body).to be_a Hash
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
      it { expect(subject.resource).to eq 'tickets' }
      it { expect(subject.for_url).to eq 'tickets' }
    end
  end
end
