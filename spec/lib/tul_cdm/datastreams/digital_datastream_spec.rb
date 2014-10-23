describe "DigitalDatastream" do

  subject do
    datastream = TulCdm::Datastreams::DigitalDatastream.new
    datastream.content = <<EODS
<foxml:datastream ID="digitalMetadata" STATE="A" CONTROL_GROUP="X" VERSIONABLE="true">
  <foxml:datastreamVersion ID="digitalMetadata.0" LABEL="digital metadata" MIMETYPE="text/xml">
    <foxml:xmlContent>
      <fields>
        <file_name>UA0001.pdf</file_name>
        <document_content>The quick brown fox jumped over the lazy dogs</document_content>
      </fields>
    </foxml:xmlContent>
  </foxml:datastreamVersion>
</foxml:datastream>
EODS
    datastream
  end

  it { is_expected.to have_term(:file_name) }
  it { is_expected.to have_term(:document_content) }

end
