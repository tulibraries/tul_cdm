require 'rails_helper'

RSpec.describe Sheetmusic, :type => :model do
  context 'Sheetmusic Class' do
    subject { Sheetmusic.new }

    it { is_expected.to have_metadata_stream_of_type(SheetmusicMetadata) }
    it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::PhysicalDatastream) }
    it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::DigitalDatastream) }
    it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::CreationDatastream) }
    it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::VolumeDatastream) }

    it { is_expected.to respond_to(:title) }
    it { is_expected.to respond_to(:downloadable) }
  end
end
