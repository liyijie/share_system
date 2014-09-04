class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :convert_format, only: [ :create, :update ]

  skip_before_filter :verify_authenticity_token

  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # GET /photos/manage
  def manage
    @photos = Photo.all
  end

  # GET /photos/update
  def check
    @count = Photo.count
    last_photo = Photo.last
    @last_id = last_photo.blank? ? 0 : last_photo.id
  end

  # DELETE /photos/destroy_multiple
  # DELETE /photos/destroy_multiple.json
  def destroy_multiple
    Photo.destroy(params[:photo_ids]) unless params[:photo_ids].blank?
    respond_to do |format|
      format.html { redirect_to photos_url, notice: "已删除." }
      format.json { head :no_content }
    end
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:title, :image)
    end

    def convert_format
      file = params[:photo][:image]
      if !file.blank? && file.present? && file.content_type == 'application/octet-stream'
        mime_type = MIME::Types.type_for(file.original_filename)    
        file.content_type = mime_type.first.content_type if mime_type.first
      end
      params[:photo][:image] = file
    end
end
