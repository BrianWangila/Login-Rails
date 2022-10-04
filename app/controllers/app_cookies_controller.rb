class AppCookiesController < ApplicationController

  def create
    data = params[:data]
    cookies[:other_info] = data
    render json: {
      message: "Other cookies has been created"
    }
  end

  def show
    render json: {
      app_cookies: cookies
    }
  end
end