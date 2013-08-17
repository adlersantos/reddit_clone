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

  validates :title, :url, :presence => true

  def comments_by_parent
    comments_by_parent = {}

    pid_column = 'comments.parent_comment_id'
    ['IS NULL', 'IS NOT NULL'].each do |nullness|
      condition = pid_column + ' ' + nullness
      populate_parents(condition, comments_by_parent)
    end

    comments_by_parent
  end

  def populate_parents(condition, hash)
    children = comments.nil? ? [] : comments.where(condition)
    children.each do |child|
      parent = Comment.find_by_id(child.parent_comment_id)
      hash[parent] ||= []
      hash[parent] << child
    end
  end

  def total_votes
    self.votes.inject(0) { |sum, vote| sum + vote.vote_value }
  end
end
