class DigitalCollectionsController < ApplicationController
  respond_to :html, :xml, :json
  before_action :verify_signed_in!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_digital_collection, only: [:show, :edit, :update, :destroy]
  
  add_breadcrumb "Home", :root_path
  add_breadcrumb "Explore Digital Collections", '/digital_collections'

  def index
    @host = "http://#{request.env["HTTP_HOST"]}/digital_collections"
    @digital_collections = viewable_collections
    respond_with(@digital_collections)
  end

  def show
    add_breadcrumb @digital_collection.name
    if is_viewable?(@digital_collection)
      respond_with(@digital_collection)
    else
      flash[:error] = t('tul_cdm.digital_collection.not_available')
      redirect_to(digital_collections_path)
    end
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
    rescue ActiveRecord::RecordNotFound
      flash[:error] = t('tul_cdm.digital_collection.not_available')
      redirect_to(digital_collections_path)
    end

    def digital_collection_params
      params.require(:digital_collection).permit(:collection_alias, :name, :image_url, :thumbnail_url, :description, :priority, :is_private, :allowed_ip_addresses, :featured, :custom_url, :is_custom_landing_page)
    end

    def verify_signed_in!
      if !user_signed_in?
        flash[:error] = t('devise.failure.unauthenticated')
        redirect_to(root_path)
      end
    end
end
