require 'rails_helper'

RSpec.describe SheetMusic, :type => :model do
  context 'SheetMusic Class' do
    subject { SheetMusic.new }

    it { is_expected.to have_metadata_stream_of_type(SheetMusicMetadata) }
    it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::PhysicalDatastream) }
    it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::DigitalDatastream) }
    it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::CreationDatastream) }
    it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::VolumeDatastream) }
  end
end
