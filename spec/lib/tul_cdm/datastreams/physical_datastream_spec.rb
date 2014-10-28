describe "PhysicalDatastream" do

  subject do
    datastream = TulCdm::Datastreams::PhysicalDatastream.new
    datastream.content = <<EODS
<foxml:datastream ID="physicalMetadata" STATE="A" CONTROL_GROUP="X" VERSIONABLE="true">
  <foxml:datastreamVersion ID="physicalMetadata.0" LABEL="physical metadata" MIMETYPE="text/xml">
    <foxml:xmlContent>
      <fields>
        <folder>Folder 5</folder>
        <location>Box 8</location>
        <physical_description>1 photograph:b&amp;w</physical_description>
      </fields>
    </foxml:xmlContent>
  </foxml:datastreamVersion>
</foxml:datastream>
EODS
    datastream
  end

  it { is_expected.to have_term(:folder) }
  it { is_expected.to have_term(:location) }
  it { is_expected.to have_term(:physical_description) }

end
