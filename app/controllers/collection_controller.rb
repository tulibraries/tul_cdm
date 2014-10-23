class CollectionController < ApplicationController
  include Hydra::Controller::ControllerBehavior
  
  helper_method :render_title, :render_blurb, :render_image_grid
  
  def index
  end
  
  def show()
    #get_type(params[:order_id])
  end
  
  def render_title(collection) 
    output = "<h1>Welcome to #{collection}</h1>"
    return output.html_safe
  end
  
  def render_blurb(collection) 
    render partial: "blockson_pamphlets"
  end
  
  
  
  def render_image_grid(collection = "p15037coll10")
    output = ''
    output = create_image_grid(collection)
    output.html_safe
    
  end
  
  
  def create_image_grid(collection)
    grid = ''
    
    featured_path="#{Rails.root}/app/controllers/featured/#{collection}_featured.xml"
    xml = Nokogiri::XML(open(featured_path))
    objects_xpath="/featured_objects/object"
    pids = xml.xpath("#{objects_xpath}/pid/text()")
    thumbnails = xml.xpath("#{objects_xpath}/path_to_thumbnail/text()")
    row_count = 0
    row_width = 3
    pids.length.times do |i|
      pval = row_count % 3
      if ((row_count % row_width == 0) && (row_count > 0))
	grid << "Here: #{pids[i]} || <br />"
      else
        grid << "Here: #{pids[i]} || "
      end
	row_count+=1
    end
    return grid
  end
  
  
  
  
end
