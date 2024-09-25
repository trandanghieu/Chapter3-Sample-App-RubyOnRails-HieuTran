class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by(id: params[:followed_id])

    @user ? (current_user.follow(@user) && redirect_to(@user)) : (
      flash[:alert] = 'User not found.'
      redirect_to request.referrer || root_url
    )
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
