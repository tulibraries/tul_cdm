class DigitalCollectionsController < ApplicationController
  respond_to :html, :xml, :json
  before_action :set_digital_collection, only: [:show, :edit, :update, :destroy]

  def index
    @host = "http://#{request.env["HTTP_HOST"]}/digital_collections"
    #@digital_collections = DigitalCollection.all
    @digital_collections = []
    remote_ip = request.remote_ip
    DigitalCollection.find_each do |collection|
      unless collection.is_private
        @digital_collections << collection
      else
        if collection.allowed_ip_addresses.split(%r{,\s*}).include? remote_ip
          @digital_collections << collection
        end
      end
    end
    respond_with(@digital_collections)
  end

  def show
    respond_with(@digital_collection)
  end

  def new
    @digital_collection = DigitalCollection.new
    respond_with(@digital_collection)
  end

  def edit
  end

  def create
    @digital_collection = DigitalCollection.new(digital_collection_params)
    flash[:notice] = 'DigitalCollection was successfully created.' if @digital_collection.save
    respond_with(@digital_collection)
  end

  def update
    flash[:notice] = 'DigitalCollection was successfully updated.' if @digital_collection.update(digital_collection_params)
    respond_with(@digital_collection)
  end

  def destroy
    @digital_collection.destroy
    respond_with(@digital_collection)
  end

  private
    def set_digital_collection
      @digital_collection = DigitalCollection.find(params[:id])
    end

    def digital_collection_params
      params.require(:digital_collection).permit(:collection_alias, :name, :image_url, :thumbnail_url, :description, :priority, :is_private, :allowed_ip_addresses)
    end
end
