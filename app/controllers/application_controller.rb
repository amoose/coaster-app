class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper


  def correct_user
  	begin
    	@user = User.find(params[:id])
    	redirect_to(root_path, :flash => { :error => 'You do not have access to this page.' }) unless current_user?(@user) || current_user.admin?
    rescue
    	# logger.info e.message
    	flash.now[:notice] = "DERP!"
    end
  end

  def admin_user
    redirect_to(root_path, :flash => { :error => 'You are not an admin.' }) unless current_user.admin?
  end

  def time_now
  	t = Time.zone.now
  end
end
