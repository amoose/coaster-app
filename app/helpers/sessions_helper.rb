module SessionsHelper
	def sign_in(user)
		cookies.permanent[:remember_token] = user.remember_token
		self.current_user = user
	end

	def current_user=(user)
		@current_user = user
		if @current_user and @current_user.ip_address != request.remote_ip and @current_user.geolocation.updated_at < 1.hour.ago
			@current_user.ip_address = request.remote_ip
			@current_user.save
		end
	end

	def current_user
		@current_user ||= User.find_by_remember_token(cookies[:remember_token])
		# redirect_to signin_url, notice: "Nobody signed in." if @current_user.nil?
	end

	def current_user?(user)
    user == current_user
  end

	def signed_in?
		!current_user.nil?
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end
end
