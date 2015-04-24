require 'rails_helper'

RSpec.describe Clipping, :type => :model do
  context 'Clipping Class' do
    subject { Clipping.new }

    it { is_expected.to have_metadata_stream_of_type(ClippingMetadata) }
    it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::GeographicDatastream) }
    it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::PhysicalDatastream) }
    it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::NotationsDatastream) }
    it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::DigitalDatastream) }
    it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::CreationDatastream) }

    it { is_expected.to respond_to(:title) }
    it { is_expected.to respond_to(:downloadable) }
  end
end
