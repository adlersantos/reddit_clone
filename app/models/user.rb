require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  attr_accessible :password, :session_token, :username

  validates :username, :password, :presence => true
  validates :username, :uniqueness => true

  has_many :owned_subs,
    :class_name => "Sub",
    :primary_key => :id,
    :foreign_key => :moderator_id

  has_many :shared_links,
    :class_name => "Link",
    :primary_key => :id,
    :foreign_key => :owner_id

  has_many :comments,
    :class_name => "Comment",
    :primary_key => :id,
    :foreign_key => :author_id

  has_many :votes,
    :class_name => "UserVote",
    :primary_key => :id,
    :foreign_key => :user_id

  has_many :voted_links,
    :through => :votes,
    :source => :link

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
