class UsersController < ApplicationController
  #ログインしているユーザー自身のプロフィールのみ編集可能
  before_action :validate_user, only: [:edit, :update]
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'プロフィールを更新しました。'
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts
    @followings = followings(@user)
    @followers = followers(@user)
  end
  
  def new
    @user = User.new

  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :introduction, :region, :password, :password_confirmation)
  end
  
  def validate_user
    current_user = User.find_by(id: session[:user_id])
    if current_user
      if current_user.id != params[:id].to_i
       flash[:alert] = "プロフィールは自分自身のプロフィールのみ編集できます。"
       redirect_to :action => "show", :id => params[:id]
      end
    end
  end

  def followings(user)
    return user.following_users.all
  end
  
  def followers(user)
    return user.followed_users.all
  end
end
