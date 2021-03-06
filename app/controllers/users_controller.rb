class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @commented_restaurants = @user.restaurants.uniq
    @favorited_restaurants = @user.favorited_restaurants.uniq

  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(@user)
      flash[:alert] = "you don't have the authority"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "user was successfully updated"
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "user was faild to update"
      render :edit
    end
  end

  def index
    @users = User.all
  end


  def friend_list
    @user = User.find(params[:id])
    @added_friends = @user.all_friends.uniq
  end


  private

  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
  end

end
