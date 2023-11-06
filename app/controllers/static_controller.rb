class StaticController < ApplicationController
  before_action :authenticate_user!, except: [:faq]
  skip_before_action :only_authorize_agent, only: [:faq]

  def faq; end
end
