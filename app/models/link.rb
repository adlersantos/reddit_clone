class Link < ActiveRecord::Base
  attr_accessible :description, :title, :url, :owner_id, :sub_ids

  has_many :sub_join_links,
    :class_name => "SubJoinLink",
    :primary_key => :id,
    :foreign_key => :link_id

  has_many :subs,
    :through => :sub_join_links,
    :source => :sub

  has_many :comments,
    :class_name => "Comment",
    :primary_key => :id,
    :foreign_key => :link_id

  has_many :votes,
    :class_name => "UserVote",
    :primary_key => :id,
    :foreign_key => :link_id

  has_many :voters,
    :through => :votes,
    :source => :voter

  belongs_to :owner,
    :class_name => "User",
    :primary_key => :id,
    :foreign_key => :owner_id

  def comments_by_parent
    comments_by_parent = {}

    top_comments = comments.where(:parent_comment_id => nil)
    top_comments.each do |comment|
      comments_by_parent[nil] ||= []
      comments_by_parent[nil] << comment
    end

    child_comments = comments.all - top_comments
    child_comments.each do |comment|
      parent_comment = Comment.find_by_id(comment.parent_comment_id)
      comments_by_parent[parent_comment] ||= []
      comments_by_parent[parent_comment] << comment
    end

    comments_by_parent
  end

  def total_votes
    self.votes.inject(0) { |sum, vote| sum + vote.vote_value }
  end
end
