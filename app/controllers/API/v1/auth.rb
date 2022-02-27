module API
  module V1
    class Auth < Grape::API
      include API::V1::Defaults
      prefix "api"
      version "v1", using: :path
      default_format :json
      format :json

      helpers do
        def create_token user
          present jwt_token: AuthToken.create(token:
            TokenProvider.encode(user_id: user.id), user_id: user.id).token
        end
      end
      resources :auth do
        desc "login"
        params do
          requires :email
          requires :password
        end
        post "/login" do
          user = User.find_by email: params[:email]
          if user.valid_password? params[:password]
            create_token user
          else
            error!("Invalid email/password combination", 401)
          end
        end

        desc "logout"
        delete "/logout" do
          authenticate_user!
          token = AuthToken.find_by token: request.headers["Jwt-Token"]
          token&.destroy
          present message: "Logged out"
        end
      end
    end
  end
end
