class UsersController < ApplicationController
  def about
  end
  def edit
  	@user=User.find(params[:id])
    if @user==current_user
    else
      redirect_to current_user
    end
  end
  def update
  	@user=User.find(params[:id])
  	if @user.update(user_params)
  	   redirect_to user_path(@user.id),notice:"You have updated user successfully."
    else
    # @user=User.find(params[:id])
    render :edit
    end
  end
  def index
  	@users=User.where.not(id: current_user.id)
    @user=current_user
    @book=Book.new
  end
  def follow
    user = User.find(params[:id])
    @users = user.followings.all
  end
  def follower
    user = User.find(params[:id])
    @users = user.followers.all
  end

  def show
  	@user=User.find(params[:id])
    @book=Book.new
    @books=@user.books
  end
  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
