describe "CreationDatastream" do

  subject do
    datastream = TulCdm::Datastreams::CreationDatastream.new
    datastream.content = <<EODS
<foxml:datastream ID="creationMetadata" STATE="A" CONTROL_GROUP="X" VERSIONABLE="true">
  <foxml:datastreamVersion ID="creationMetadata.0" LABEL="Creation metadata" MIMETYPE="text/xml">
    <foxml:xmlContent>
      <fields>
        <created>John Doe</created>
        <creator>Richard Roe</creator>
      </fields>
    </foxml:xmlContent>
  </foxml:datastreamVersion>
</foxml:datastream>
EODS
    datastream
  end

  it { is_expected.to have_term(:created) }
  it { is_expected.to have_term(:creator) }

end
