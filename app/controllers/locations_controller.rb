class LocationsController < ApplicationController
  # GET /locations
  def index
    @locations = Location.all
  end

  # GET /locations/1
  def show
    location
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # POST /locations
  def create
    @location = Location.new(location_params)

    if location.save
      redirect_to location, notice: "Location was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /locations/1/edit
  def edit
    location
  end

  # PATCH/PUT /locations/1
  def update
    if location.update(location_params)
      redirect_to location, notice: "Location was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /locations/1
  def destroy
    if location.destroy
      redirect_to locations_url, notice: "Location was successfully destroyed."
    else
      redirect_to location, alert: location.errors.full_messages.to_sentence
    end
  end

  def new_sub_location
    @sub_location = location.children.build
  end

private

  def location
    @location ||= Location.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def location_params
    params.require(:location).permit(:name, :description, :parent_id, :tag_list)
  end
end
