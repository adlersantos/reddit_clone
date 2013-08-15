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

  belongs_to :owner,
    :class_name => "User",
    :primary_key => :id,
    :foreign_key => :owner_id
end
