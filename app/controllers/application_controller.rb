class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :development_ip
  # before_action :position

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path,
                flash: {
                  error: 'You do not have access to this page.'
                }) unless current_user?(@user) || current_user.admin?
  rescue
    # logger.info e.message
    flash.now[:notice] = 'DERP!'
  end

  def admin_user
    redirect_to(root_path, flash: { error: 'You are not an admin.' }) unless current_user.admin?
  end

  def time_now
    Time.now
    # Time.new(2000,1,1,t.hour,t.min,t.sec)
  end

  def development_ip
    if Rails.env.development?
      ActionDispatch::Request.class_eval do
        def remote_ip
          uri = URI.parse('http://api.ipify.org?format=json')
          http = Net::HTTP.new(uri.host, uri.port)

          request = Net::HTTP::Get.new(uri.request_uri)
          JSON.parse(http.request(request).body)['ip']
        end
      end
    end
  end
end
