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

  def tag_cloud(tags, classes)
    max_count = tags.sort_by(&:count).last.count.to_f
    tags.each do |tag|
      index = ((tag.count / max_count) * (classes.size - 1)).round
      yield tag, classes[index]
    end
  end

end
