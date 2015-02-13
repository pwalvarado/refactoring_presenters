class FriendsController < ApplicationController
  def index
    @user_friends = FriendsListPresenter.new(current_user).populate
  end
end
