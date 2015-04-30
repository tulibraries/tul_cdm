require 'rails_helper'

RSpec.describe Poster, :type => :model do
  context 'Poster Class' do
    subject { Poster.new }

    it { is_expected.to have_metadata_stream_of_type(PosterMetadata) }
    it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::PhysicalDatastream) }
    it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::DigitalDatastream) }
    it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::NotationsDatastream) }
    it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::CreationDatastream) }

    it { is_expected.to respond_to(:title) }
    it { is_expected.to respond_to(:downloadable) }
    it { is_expected.to respond_to(:Downloadable_OCR) }
  end
end
