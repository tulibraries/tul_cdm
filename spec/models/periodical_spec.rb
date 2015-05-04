require 'rails_helper'

RSpec.describe Periodical, :type => :model do
  context 'Periodical Class' do
    subject { Periodical.new }

    it { is_expected.to have_metadata_stream_of_type(PeriodicalMetadata) }
    it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::NotationsDatastream) }
    it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::DigitalDatastream) }
    it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::CreationDatastream) }

    it { is_expected.to respond_to(:title) }
    it { is_expected.to respond_to(:downloadable) }
    it { is_expected.to respond_to(:downloadable_ocr) }
  end
end
