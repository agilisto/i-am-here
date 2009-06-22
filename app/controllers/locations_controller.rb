include GeoKit::Geocoders
DEFAULT_LATITUDE = -29.858106
DEFAULT_LONGITUDE = 31.025566


class LocationsController < ApplicationController
  geocode_ip_address :only => [:new]  
  
  before_filter :create_map, :except => [:index]
  before_filter :find_location, :only => [:show, :edit, :update]
  
  # GET /locations
  # GET /locations.xml
  def index
    @locations = Location.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @locations }
    end
  end

  # GET /locations/1
  # GET /locations/1.xml
  def show
    create_marker
    @map.center_zoom_on_bounds_init([ [@location.latitude,@location.longitude],
        [@location.latitude,@location.longitude]])
    #@map.show_map_blowup(GLatLng.new([@location.latitude,@location.longitude]), :mapType => :G_HYBRID_MAP)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @location }
    end
  end

  # GET /locations/new
  # GET /locations/new.xml
  def new
    @location = Location.new
    create_draggable

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @location }
    end
  end

  # GET /locations/1/edit
  def edit; end

  # POST /locations
  # POST /locations.xml
  def create
    @location = Location.new(params[:location])

    respond_to do |format|
      if @location.save
        flash[:notice] = 'Location was successfully created.'
        format.html { redirect_to(@location) }
        format.xml  { render :xml => @location, :status => :created, :location => @location }
        format.js
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.xml
  def update
    respond_to do |format|
      if @location.update_attributes(params[:location])
        flash[:notice] = 'Location was successfully updated.'
        format.html { redirect_to(@location) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.xml
  #def destroy
  #  @location = Location.find(params[:id])
  #  @location.destroy

  #  respond_to do |format|
  #    format.html { redirect_to(locations_url) }
  #    format.xml  { head :ok }
  #  end
  #end
  
  def geocode
    @loc = MultiGeocoder.geocode(params[:location][:location])
    @map = Variable.new("map")
    @draggable = Variable.new('draggable')
    
    respond_to do |format|
      if @loc.success 
        format.html # new.html.erb
        format.xml  { render :xml => @location }
        format.js
      else
        format.html {}
        format.xml {}
        format.js #{ render :update  do |page| page.replace_html :error, "Failed to geocode, please try again." end }
      end
    end
  end
  
  
  private
  def find_location
    @location = Location.find_by_link(params[:id])
    @comment = Comment.new
  end
  
  def create_draggable(lat = DEFAULT_LATITUDE, lng = DEFAULT_LONGITUDE)
    draggable = GMarker.new([lat,lng], :draggable => true, :name => "draggable", :title => "Pinpoint me", 
      :info_window => "Drag me to the desired location", :bouncy => true)
    @map.overlay_global_init(draggable, "draggable")
    @map.event_init draggable, :dragend, 
      "function() { 
          var lat = draggable.getLatLng().lat();
          var lng = draggable.getLatLng().lng();
          $('location_longitude').value = lng;
          $('location_longitude').value = lat;
        }"
    draggable
  end
  
  def create_marker
    marker = GMarker.new([@location.latitude,@location.longitude], :name => "marker", :title => @location.name,
      :info_window => @location.description, :bouncy => true)
       
    @map.overlay_global_init(marker, "marker")
    marker
  end
end
