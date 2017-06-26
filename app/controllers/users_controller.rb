class UsersController < ApplicationController
	before_action :authenticate_user!
	after_action :verify_authorized

  def new
    @user = User.new
  end


  def create
    @user = User.new
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.save
      flash[:notice] = "Welcome to Blocipedia #{@user.name}!"
      redirect_to root_path
    else
      flash.now[:alert] = "There was an error creating your account. Please try again"
      render :new
    end
  end
	
def show
    authorize :user, :show?
  end

  def downgrade
    current_user.update_attribute(:role, 'standard')
    flash[:alert] = "You have downgraded your account, #{current_user.email}"
    redirect_to root_path
  end

end
