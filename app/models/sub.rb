class Sub < ActiveRecord::Base
  attr_accessible :moderator_id, :name, :links_attributes

  belongs_to :moderator,
    :class_name => "User",
    :primary_key => :id,
    :foreign_key => :moderator_id

  has_many :sub_join_links,
    :class_name => "SubJoinLink",
    :primary_key => :id,
    :foreign_key => :sub_id

  has_many :links,
    :through => :sub_join_links,
    :source => :link

  accepts_nested_attributes_for :links, :reject_if => :all_blank

  validates :name, :presence => true

  def sorted_links
    links = self.links
    links.sort{ |a, b| b.total_votes <=> a.total_votes }
  end
end
