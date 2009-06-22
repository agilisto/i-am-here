# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'ecf5efc2fa36776ae84d256145c83e49'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  protected
  def create_map
    @map = GMap.new("map")
    @map.enable_continuous_zoom
    @map.control_init(:large_map => true,:map_type => true)
    @map.add_map_type_init(:G_PHYSICAL_MAP)
    #    @map.set_map_type_init(:G_HYBRID_MAP)
    if @location
      lat = @location.latitude
      lng = @location.longitude 
    else
      lat = DEFAULT_LATITUDE
      lng = DEFAULT_LONGITUDE
    end
    @map.center_zoom_init([lat, lng], 11)
  end
end
