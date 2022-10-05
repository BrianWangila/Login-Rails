class UserController < ApplicationController

  def create
    user = User.create(user_params)
    if user.valid?
      render json: {
        message: "User created successfully"
      }, status: :created
    else
      render json: {
        error: user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end


  def login
    user = User.find_by(username: params[:username])

    if user&.authenticate(params[:password])
      session[:uid] = user.id
      render json: {
        message: "user logged in successfully"
      }, status: :ok
    else
      render json: {
        message: "Invalid username or password"
      }, status: :unprocessable_entity
    end

    # similar to this

    # if user
    #   authenticated = user.authenticate(params[:password])
    #   if authenticated
    #     session[:uid] = user.id
    #     render json: {
    #       message: "user logged in successfully"
    #     }, status: :ok
    #     else
    #       render json: {
    #         message: "Invalid password!"
    #       }, status: :unprocessable_entity
    #   end
    # else
    #   render json: {
    #     message: "No user found!"
    #   }, status: :unprocessable_entity
    # end
  end


  private

  def user_params
    params.permit(:username, :password)
  end
end
