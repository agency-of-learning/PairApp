# ./app/controllers/concerns/secured.rb
module Secured
  extend ActiveSupport::Concern

  included do
    before_action :logged_in_using_omniauth?
  end

  def logged_in_using_omniauth?
    redirect_to '/' if session[:userinfo].blank?
  end
end
