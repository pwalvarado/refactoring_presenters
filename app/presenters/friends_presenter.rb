class FriendsPresenter
  attr_accessor :user, :friends

  def initialize(user)
    self.user = user
  end

  def populate
    self.friends = user.friends.each_with_object([]) do |friend, memo|
      friend.extend(PresentableFriend)
      set_news_posts_count(friend)
      friend.friends_in_common = common_friends_by_friend_id[friend_id].each do |common_friend|
        common_friend.extend(PresentableFriend)
        set_news_posts_count(common_friend)
      end
      memo << friend
    end
  end


  module PresentableFriend
    attr_accessor :news_posts_count, :friends_in_common
  end

  def set_news_count(friend)
    friend.news_post_count = post_counter.counts_for_user(friend.id)
  end
  private :set_news_count

  def post_counter
    @post_counter ||= NewsPostCounter.new(friends_list)
  end
  private :post_counter

  class NewsPostCounter
    attr_accessor :users

    def initialize(users)
      self.users = users
    end

    def counts_for_user(user_id)
      all_counts[user_id] || 0
    end

    def all_counts
      @all_counts ||= NewsPost.where(user_id: users).group(:user_id).count
    end
    private :all_counts
  end

  def friends_list
    @friends_list ||= (friends + common_friends_list.common_friends)
  end
  private :friends_list

  def common_friends_list
    @common_friends_list ||= CommonFriendsList.new(user.id, friends)
  end

  class CommonFriendsList
    attr_accessor :user_id, :friends

    def initialize(user_id, friends)
      self.user_id = user_id
      self.friends = friends
    end

    def common_friends
      @common_friends ||= User.select('friendships.user_id, user.*')
          .joins(:friendships)
          .where(friendships: {user_id: friends})
          .joins('inner join friendships fs2 on fs2.user_id = friendships.friend_id')
          .where(['fs2.friend_id = ?', user.id])
    end
  end
end

