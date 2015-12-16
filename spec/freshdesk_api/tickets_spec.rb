require 'spec_helper'
module FreshdeskAPI
  describe Tickets do
    it { expect(described_class.resource).to eq 'tickets' }
    it { expect(described_class.for_url).to eq 'tickets' }
    describe '::index' do
      let(:request) do
        VCR.use_cassette('tickets_index') do
          described_class.index
        end
      end
      it 'status' do
        expect(request.status).to eq 200
      end
      it 'body' do
        expect(request.body).to be_a Array
      end
    end

    describe '::create' do
      # before do
      #   FileUtils.rm File.join(VCR.configuration.cassette_library_dir, 'tickets_post.yml'), force: true
      # end
      let(:params) do
        {
          helpdesk_ticket:{
              description:"Some details on the issue ...",
              subject:"Support needed..",
              email:"apanach@path.travel",
              priority: 1,
              status: 2,
              source: 2
          },
          cc_emails:"alopez@path.travel"
        }
      end
      let(:request) do
        VCR.use_cassette('tickets_post') do
          described_class.create(params)
        end
      end
      it 'status' do
        expect(request.status).to eq 200
      end
      it 'body' do
        expect(request.body).to be_a Hash
      end
    end

    describe '::show' do
      let(:request) do
        VCR.use_cassette('tickets_show') do
          described_class.show(7)
        end
      end
      it 'status' do
        expect(request.status).to eq 200
      end
      it 'body' do
        expect(request.body).to be_a Hash
      end
    end
    describe 'instance' do
      subject { described_class.new }
      it { expect(subject.resource).to eq 'tickets' }
      it { expect(subject.for_url).to eq 'tickets' }
    end
  end
end
