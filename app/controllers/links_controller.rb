class LinksController < ApplicationController
  def new
    @all_subs = Sub.all
    render :new
  end

  def create
    @link = Link.new(params[:link])
    if @link.save
      redirect_to link_url(@link)
    else
      flash.notice = "Link submission failed."
      render :new
    end
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
end
