class StaticController < ApplicationController
  before_action :authenticate_user!, except: [:faq]
  def faq
  end
end