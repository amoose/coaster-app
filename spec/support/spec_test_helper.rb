module SpecTestHelper
  def valid_params
    { name: @user.name,
      email: "unique@email.com",
      password: @user.password,
      password_confirmation: @user.password_confirmation,
      ip_address: @user.ip_address}
  end

  def invalid_params
    valid_params.merge(gar: "bage")
  end

  def session_valid_params
    { session:
      { email: @user.email,
        password: @user.password }}
  end

  def session_invalid_params
    { session:
      { email: @user.email,
        password: "wrongpassword" }}
  end

  def sign_in_user
    valid_params

    post :create, { user: valid_params}
  end

  def sign_in_admin
    @admin = User.create(:name => 'admin',
                         :email => 'ad@min.com',
                         :password => 'foobar',
                         :password_confirmation => 'foobar',
                         :admin => true, :ip_address => '127.0.0.1')

    allow(controller).to receive(:sign_in){@admin}
  end
end


