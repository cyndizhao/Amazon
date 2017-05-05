class Api::V1::ProductsController < ApplicationController
  before_action :authenticate_user
  skip_before_filter :verify_authenticity_token

  def index
    @products = Product.last(20)
  end

  def show
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(params.require(:product).permit(:title, :description, :price))
    @product.user = @user
    if @product.save
      render json: @product
    else
      render json: @product.errors.full_messages, status: 500
    end
  end

  private
  def authenticate_user
    @user = User.find_by_api_token params[:api_token]
    head :unauthorized if @user.blank?
  end



end
