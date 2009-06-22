class CommentsController < ApplicationController
  def index
  end

  def new
    @parent = parent_object
    @comment = Comment.new
  end

  def create

    @location = Location.find_by_link(params[:location_id])
    
    @comment = @location.comments.build(params[:comment])

    if @comment.valid? and @comment.save
      redirect_to location_url(@location)
    else
      render location_url(@location)
    end

  end
 
end
