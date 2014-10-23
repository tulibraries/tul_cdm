describe 'Base' do
  subject { TulCdm::Models::Base.new }

  it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::ContentdmDatastream) }
  it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::ObjectDatastream) }
  it { pending("TBD"); is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::CreationDatastream) }
  it { pending("TBD"); is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::DigitalDatastream) }
  it { pending("TBD"); is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::GeographicDatastream) }
  it { pending("TBD"); is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::NotationsDatastream) }
  it { pending("TBD"); is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::PhysicalDatastream) }
  it { pending("TBD"); is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::RightsDatastream) }
  it { pending("TBD"); is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::VolumeDatastream) }
end
