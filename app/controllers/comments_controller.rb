class CommentsController < ApplicationController
  def index
    @comments = Comment.find(:all)
  end

  def new
    @parent = parent_object
    @comment = Comment.new
  end

  def create
    @location = Location.find_by_link(params[:location_id])
    @comment = @location.comments.build(params[:comment])

    if @comment.valid? and @comment.save
      respond_to do |format|
        format.html{ redirect_to location_url(@location) }
        format.js
      end
    else
      render location_url(@location)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.delete
    flash[:notice] = "Comment deleted"
    redirect_to comments_url
  end
end
