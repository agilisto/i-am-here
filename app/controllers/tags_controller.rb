class TagsController < ApplicationController
  def index
    @location = Location
  end

  def show
    @tag = Tag.find(params[:id])
    @locations = Location.find_tagged_with(@tag.name)
  end

end
