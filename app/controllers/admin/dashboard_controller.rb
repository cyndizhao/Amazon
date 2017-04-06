class Admin::DashboardController < ApplicationController
  def index
    @products = Product.all
    @reviews = Review.all
    @users = User.all
  end
end
