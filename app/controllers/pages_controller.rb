class PagesController < ApplicationController
  def home
  end

  def dashboard
    @session = Current.session
  end
end
