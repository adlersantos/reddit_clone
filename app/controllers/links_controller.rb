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

    @votes = @link.votes.where(
               :user_id => current_user.id,
               :link_id => @link.id
               )
    @voted = (@votes.empty? ? false : true)

    @total_votes = @link.votes.inject(0) { |sum, vote| sum + vote.vote_value }
    render :show
  end

  def index
    @links = Link.all
    @sorted_links = @links.sort{ |a, b| b.total_votes <=> a.total_votes }
    render :index
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
    @link = Link.find(params[:link_id])
    ActiveRecord::Base.transaction do
      UserVote.create!(params[:user_vote])
    end
    redirect_to link_url(@link)
  end

  def downvote
    @link = Link.find(params[:link_id])
    ActiveRecord::Base.transaction do
      UserVote.create!(params[:user_vote])
    end
    redirect_to link_url(@link)
  end
end
