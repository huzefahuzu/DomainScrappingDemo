class HomeController < ApplicationController
  # Using it just as home page.
  before_action :authenticate_user!

  def index
  end
end
