describe "VolumeDatastream" do

  subject do
    datastream = TulCdm::Datastreams::VolumeDatastream.new
    datastream.content = <<EODS
<foxml:datastream ID="volumeMetadata" STATE="A" CONTROL_GROUP="X" VERSIONABLE="true">
  <foxml:datastreamVersion ID="volumeMetadata.0" LABEL="ContentDM metadata" MIMETYPE="text/xml">
    <foxml:xmlContent>
      <fields>
        <local_call_number>ABC.123</local_call_number>
      </fields>
    </foxml:xmlContent>
  </foxml:datastreamVersion>
</foxml:datastream>
EODS
    datastream
  end

  it { is_expected.to have_term(:local_call_number) }

end
