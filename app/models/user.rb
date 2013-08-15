require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  attr_accessible :password, :session_token, :username

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

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
