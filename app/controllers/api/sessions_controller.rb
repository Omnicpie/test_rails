class Api::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    # Changing scope from :api_v1_user to :user
    Devise.mappings[:user] = Devise.mappings[:api_user]
    warden.config[:default_strategies][:user] =  warden.config[:default_strategies].delete(:api_user)
    auth_opts = auth_options
    auth_opts[:scope] = :user

    self.resource = warden.authenticate!(auth_opts)

    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?

    render json: current_api_user
  end

  # def create
  #   unless request.format == :json
  #     sign_out # why is this needed?
  #     render status: 406,
  #             json: { message: "JSON requests only." } and return
  #   end
  #   # auth_options should have `scope: :api_customer`
  #   user = warden.authenticate!(params[:user])
  #   sign_in(:user, user)
  #   if user.blank?
  #     render status: 401,
  #             json: { response: "Access denied." } and return
  #   end
  #   sign_in(resource_name, user)
  #   respond_with user, location: after_sign_in_path_for(user) do |format|
  #     format.json {
  #       render json: { token: current_token, user: user }
  #     }
  #   end
  # end

  # private

  # def current_token
  #   request.env["warden-jwt_auth.token"]
  # end
end
