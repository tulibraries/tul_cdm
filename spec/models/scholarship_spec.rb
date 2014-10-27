require 'rails_helper'

RSpec.describe Scholarship, :type => :model do
  context 'Scholarship Class' do
    subject { Scholarship.new }

    it { is_expected.to have_metadata_stream_of_type(ScholarshipMetadata) }
    it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::DigitalDatastream) }
    it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::CreationDatastream) }
    it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::VolumeDatastream) }
  end
end
  