require 'spec_helper'
module FreshdeskAPI
  describe Requester do
    describe Ticket do
      describe 'Passing and instance' do
        subject { Requester.new(described_class.new) }
        it { expect(subject.resource_for_url).to eq 'tickets' }
        it { expect(subject.url).to eq 'https://pathtravel.freshdesk.com/helpdesk/tickets' }
      end
      let(:ticket_number) { 15 }
      describe '::index' do
        let(:index_request) do
          VCR.use_cassette('tickets_index') do
            Requester.new(described_class).index
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
            Requester.new(described_class).create(params)
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
            Requester.new(described_class).show(ticket_number)
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
            Requester.new(described_class).update(ticket_number, params)
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
            Requester.new(described_class).destroy(ticket_number)
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
        subject { Requester.new(described_class) }
        it { expect(subject.resource_for_url).to eq 'tickets' }
      end
    end
  end
end
