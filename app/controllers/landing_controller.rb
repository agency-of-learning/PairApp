class LandingController < ApplicationController
  # include Secured

  def index
    # session[:userinfo] was saved earlier on Auth0Controller#callback
    @user = session[:userinfo]
  end
end
