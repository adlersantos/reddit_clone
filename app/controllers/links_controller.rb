class LinksController < ApplicationController
  before_filter :authenticate_user

  def new
    @all_subs = Sub.all
    render :new
  end

  def create
    ActiveRecord::Base.transaction do
      @link = Link.create!(params[:link])

      unless params[:comment][:body].blank?
        @comment = Comment.new(params[:comment])
        @comment.link_id = @link.id
        @comment.save!
      end
    end
    redirect_to link_url(@link)
  end

  def show
    @link = Link.find(params[:id])
    render :show
  end

  def edit
    @all_subs = Sub.all
    @link = Link.find(params[:id])
    render :edit
  end

  def update
    @link = Link.find(params[:id])
    @link.update_attributes(params[:link])
    redirect_to link_url(@link)
  end

  def upvote
    @link = Link.find(params[:id])
    ActiveRecord::Base.transaction do

    end
  end

  def downvote
  end
end
