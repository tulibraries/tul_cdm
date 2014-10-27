describe 'Audiovisual' do
  subject { TulCdm::Models::Audiovisual.new }
  it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::AvDatastream) }
  it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::ContentdmDatastream) }
  it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::ObjectDatastream) }
end
