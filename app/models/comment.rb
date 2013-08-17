class Comment < ActiveRecord::Base
  attr_accessible :author_id, :body, :link_id, :parent_comment_id

  validates :body, :presence => true

  belongs_to :author,
    :class_name => "User",
    :primary_key => :id,
    :foreign_key => :author_id

  belongs_to :parent,
    :class_name => "Comment",
    :primary_key => :id,
    :foreign_key => :parent_comment_id

  has_many :child_comments,
    :class_name => "Comment",
    :primary_key => :id,
    :foreign_key => :parent_comment_id

  belongs_to :link,
    :class_name => "Link",
    :primary_key => :id,
    :foreign_key => :link_id
end
