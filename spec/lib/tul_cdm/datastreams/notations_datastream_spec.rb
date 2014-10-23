describe "NotationsDatastream" do

  subject do
    datastream = TulCdm::Datastreams::NotationsDatastream.new
    datastream.content = <<EODS
<foxml:datastream ID="notationsMetadata" STATE="A" CONTROL_GROUP="X" VERSIONABLE="true">
  <foxml:datastreamVersion ID="notationsMetadata.0" LABEL="notations metadata" MIMETYPE="text/xml">
    <foxml:xmlContent>
      <fields>
        <notes>Lorem ipsum dolor sit amet, at cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</notes>
        <personal_names>Heather Douglas</personal_names>
        <personal_names>Peter Quill</personal_names>
      </fields>
    </foxml:xmlContent>
  </foxml:datastreamVersion>
</foxml:datastream>
EODS
    datastream
  end

  it { is_expected.to have_term(:notes) }
  it { is_expected.to have_term(:personal_names) }

end
