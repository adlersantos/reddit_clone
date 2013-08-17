module LinksHelper
  def perform_vote
    @link = Link.find(params[:link_id])
    ActiveRecord::Base.transaction do
      UserVote.create!(params[:user_vote])
    end
    redirect_to link_url(@link)
  end
end
