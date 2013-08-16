class SubsController < ApplicationController
  before_filter :authenticate_user

  def new
    @sub = Sub.new
    3.times { @sub.links.build }
    render :new
  end

  def create
    # ActiveRecord::Base.transaction do
    #   @sub = Sub.new(params[:sub])
    #   @sub.save!

    #   params[:link].each do |link_params|
    #     next if (link_params[:title].blank? && link_params[:url].blank?)

    #     @link = Link.create!(link_params)
    #     SubJoinLink.create!(:link_id => @link.id, :sub_id => @sub.id)
    #   end
    # end
    # redirect_to sub_url(@sub)

    @sub = Sub.new(params[:sub])
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.notice = "Submission failed."
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end
end