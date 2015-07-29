class UsersController < ApplicationController
  #ログインしているユーザー自身のプロフィールのみ編集可能
  before_action :validate_user, only: [:edit, :update]
  
  def edit
  
  end
  
  def update
    
  end
  
  def show
    @user = User.find(params[:id])
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
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def validate_user
    if current_user.id != params[:id]
       flash.now[:alert] = "プロフィールは自分自身のプロフィールのみ編集できます。"
       redirect_to :action => "show", :id => params[:id]
    end
  end
  
end
