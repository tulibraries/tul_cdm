describe 'Base' do
  subject { TulCdm::Models::Base.new }

  it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::ContentdmDatastream) }
  it { is_expected.to have_metadata_stream_of_type(TulCdm::Datastreams::ObjectDatastream) }

end
