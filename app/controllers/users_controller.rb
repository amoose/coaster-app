class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index, :destroy, :update_geolocation]
  before_filter :correct_user,   only: [:edit, :update, :show, :update_geolocation]
  before_filter :admin_user,     only: :destroy
  skip_before_filter :verify_authenticity_token, only: [:update_geolocation]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new # :city => request.location.city
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = 'Welcome to the CoasterApp!'
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def update_geolocation
    @user = User.find(params[:id])
    if @user == current_user
      @user.tracking = true
      @user.geolocation = Geolocation.new latitude: params[:latitude], longitude: params[:longitude], accuracy: 1
      # @user.save :validate => false
      @user.geolocation.save validate: false # skip the auto-geocode in geolocation model

      render json: @user.geolocation
    end
  end

  def destroy
    User.find(params[:id]).destroy unless current_user?(User.find(params[:id]))
    flash[:success] = 'User destroyed.'
    redirect_to users_url
  end

  def locator
    render partial: 'shared/locator'
  end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :ip_address)
  end
end
