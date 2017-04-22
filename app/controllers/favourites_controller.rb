class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def index
    user = User.find(params[:user_id])
    @products = user.favourite_products

    render 'products/index'
    #????????????????????????
  end
  def create
    product = Product.find(params[:product_id])
    favourite = Favourite.new(user: current_user, product: product)
    if cannot? :favourite, product
      redirect_to product_path(product), alert: 'Favourite your own product is disgusting'
      return
    end
    if favourite.save
      redirect_to product_path(product), notice: 'Product liked!'

    else
      redirect_to product_path(product), alert: favourite.errors.full_messages(',')
    end
  end

  def destroy
    favourite = Favourite.find(params[:id])
    if cannot? :favourite, favourite.product
      redirect_to product_path(favourite.product), alert: 'Can not Unfavourite your own product'
      return
    end

    if favourite.destroy
      redirect_to product_path(favourite.product), notice:'Un-favourited question!'
    else
      redirect_to product_path(favourite.product), alert: favourite.errors.full_messages.join(', ')
    end
  end
end
