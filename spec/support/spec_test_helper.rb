module SpecTestHelper
  # User Controller Helpers
  def valid_params
    { name: @user.name,
      email: 'unique@email.com',
      password: @user.password,
      password_confirmation: @user.password_confirmation,
      ip_address: @user.ip_address }
  end

  def invalid_params
    valid_params.merge(gar: 'bage')
  end

  # Session Controller Helpers

  def new_session
    original_controller = @controller

    @controller = SessionsController.new

    post :create, session: { email: @user.email, password: @user.password }

    @controller = original_controller
  end

  def session_valid_params
    { session:
      { email: @user.email,
        password: @user.password } }
  end

  def session_invalid_params
    { session:
      { email: @user.email,
        password: 'wrongpassword' } }
  end

  def sign_in_user
    @controller = UsersController.new
    valid_params

    post :create, user: valid_params
  end

  def sign_in_admin
    @admin = User.create(name: 'admin',
                         email: 'ad@min.com',
                         password: 'foobar',
                         password_confirmation: 'foobar',
                         admin: true, ip_address: '127.0.0.1')

    allow(controller).to receive(:sign_in) { @admin }
  end

  # Destination Controller Helpers
  def destination_attributes
    da = @destination.attributes
    da.delete('user_id')
    da
  end

  def destination_valid_params
    { destination:
      { id: 2,
        name: 'Another place',
        address1: '456 another drive',
        address2: '',
        city: 'Another City',
        state: 'Another State',
        zip: '23456',
        user_id: '' } }
  end

  def destination_invalid_params
    { destination:
      { gar: 'bage',
        name: 'Another place',
        address1: '456 another drive',
        address2: '',
        city: 'Another City',
        state: 'Another State',
        zip: '23456',
        user_id: '' } }
  end

  def string_keys(hash)
    new_hash = {}
    hash.each_pair do |key, value|
      new_hash[key.to_s] = value
    end
    new_hash
  end

  def destination_updated_params
    new_hash = destination_valid_params
    new_hash[:destination][:name] = 'Updated Name'
    new_hash
  end

  # Static Pages Controller Helper
  def set_user_location(user)
    geo = user.geolocation
    geo.latitude = 32.7157
    geo.longitude = -117.1611
    geo.fetch_address
    geo.save
  end
end
