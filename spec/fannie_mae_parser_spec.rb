require 'spec_helper'

describe FannieMaeParser do

  context '.process' do
    let(:klass) {FannieMaeParser::Document::Base}
    let(:doc_outcome) {'success'}
    let(:path) { File.expand_path("spec/documents/#{doc_outcome}/#{doc}") }

    subject { FannieMaeParser.process(path) }

    context 'success' do
      let(:doc) { 'fm_001.txt' }

      it 'parses the document' do
        expect(subject.errors.empty?).to be_truthy
      end
    end

    context 'failure' do
      let(:doc_outcome) {'failure'}

      describe 'invalid path' do
        let(:doc) { 'bad_file_name.txt' }
        let(:error) { ArgumentError }
        let(:msg) { "document:'#{path}', does not exist." }

        it 'raises ArgumentError' do
          expect { subject }.to raise_error(error, msg)
        end
      end
    end
  end

  describe 'version' do
    let(:current_version) { '0.1.0' }
    subject { FannieMaeParser::VERSION }

    it 'has a version number' do
      expect(subject).to eq(current_version)
    end
  end

end
