# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def button_to_remote(name, options = {}, html_options = {})
    button_to_function(name, remote_function(options), html_options)
  end
  
  # Uses jQuery to toggle the visibily of a div
  def show_element(element)
    update_page do |page|
      page[element].show
    end
  end
  
  def hide_element(element)
    update_page do |page|
      page[element].hide
    end
  end
  
end
