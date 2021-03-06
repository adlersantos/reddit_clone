class UserVote < ActiveRecord::Base
  attr_accessible :user_id, :link_id, :vote_value

  validates :vote_value,
    :presence => true,
    :numericality => true,
    :inclusion => [-1, 1]

  belongs_to :voter,
    :class_name => "User",
    :primary_key => :id,
    :foreign_key => :user_id

  belongs_to :link,
    :class_name => "Link",
    :primary_key => :id,
    :foreign_key => :link_id
end
