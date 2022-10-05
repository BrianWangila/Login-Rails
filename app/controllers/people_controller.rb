class PeopleController < ApplicationController

  #the following should run only if you are authorized
  before_action :authorized?
  skip_before_action :authorized?, only: [:login, :create_account]

  def login
    hashed_password = Digest::MD5.new
    username = params[:username]
    hashed_password.update(params[:password])


    user = Person.where(
      username: username, password: hashed_password.hexdigest
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


  def create_account
    hashed_password = Digest::MD5.new
    hashed_password.update(params[:password])

    brian = Person.create(username: params[:username], password: hashed_password.hexdigest)
    render json: {
      message: "Successfully creating account"
    }, status: :created
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

