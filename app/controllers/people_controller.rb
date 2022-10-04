class PeopleController < ApplicationController

  #the following should run only if you are authorized
  before_action :authorized?
  skip_before_action :authorized?, only: [:login]

  def login
    username = params[:username]
    password = params[:password]

    user = Person.where(
      username: username, password: password
    ).first

    if user

      session[:user] = user.id

      render json: {
        message: "Successfully logged in",
        data: user
      }, status: :ok
    else
      render json: {
        message: "Failed login"
      }, status: :unauthorized
    end
  end

  def show
    users = Person.all
    render json: {
      people: users
    }
  end

  def logout
    session.delete :user
    render json: {
      message: "Logged out successfully"
    }
  end

  private

  def person_params
    params.permit(:username, :password)
  end

  def authorized?
    return render json: {
      message: "failed",
      error: "You are not authorized to view this page."
    }, status: :unauthorized unless session.include? :user
    
  end
end

