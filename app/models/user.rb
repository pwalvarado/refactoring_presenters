class User < ActiveRecord::Base

  #many to many self join http://stackoverflow.com/questions/3396831/rails-many-to-many-self-join
  has_many :friendships#, :foreign_key => "user_id", :class_name => "Friendship"

  #renaming the association
  #http://stackoverflow.com/questions/4632408/need-help-to-understand-source-option-of-has-one-has-many-through-of-rails
  has_many :friends, :through => :friendships #, source: :user
  has_many :news_posts

  def full_name
    "#{first_name} #{last_name}"
  end

  def friends_in_common(friend)
    friends & friend.friends
  end
end
