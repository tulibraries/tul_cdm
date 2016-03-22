class HarvestedCollection
  attr_accessor :digital_collection_id
  attr_accessor :xml_objects

  def add_object(new_object)
    xml_objects.merge!(new_object)
  end

  def delete_object(pid)
    xml_objects.delete(pid)
  end
end
