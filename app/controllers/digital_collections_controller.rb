class DigitalCollectionsController < ApplicationController
  respond_to :html, :xml, :json
  before_action :set_digital_collection, only: [:show, :edit, :update, :destroy]

  def index
    @digital_collections = DigitalCollection.all
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
      params.require(:digital_collection).permit(:collection_alias, :name, :image_url, :thumbnail_url, :description, :priority)
    end
end
