class ProductsController < ApplicationController
  # before_action :authenticate_user!, except: [:index, :show]

  def new
    @product = Product.new
  end

  def index
    @products = Product.last(20)
  end

  def create
    product_params = params.require(:product).permit([:title, :description, :price])
    @product = Product.new(params.require(:product).permit(:title, :description, :price, :category_id))
    @product.user = current_user
    if @product.save
      flash[:notice] = "New product created"
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def show
    @product = Product.find params[:id]
    # @review = Review.new
  end

  def edit
    @product = Product.find params[:id]
  #   redirect_to root_path, alert:'access denied' unless can? :edit, @product
  end

  def update

    @product = Product.find params[:id]
    product_params = params.require(:product).permit([:title, :description, :price, :category_id])
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit
    end
    # if !(can? :edit, @product)
    #   redirect_to root_path, alert:'access denied'
    # elsif @product.update(product_params)
    #   redirect_to product_path(@product)
    # else
    #   render :edit
    # end
  #   # if @product.user != current_user
  #   #   flash[:alert] = "You cannot change a product that you did not create"
  #   #   redirect_to product_path(@product)
  #   # elsif @product.update(product_params)
  #   #   redirect_to product_path(@product)
  #   # else
  #   #   render :edit
  #   # end
  #   # You CAN'T change a product that you did not create
  end

  def destroy
    # if !(can? :destroy, @product)
    #   redirect_to root_path, alert:'access denied'
    # else
      product = Product.find params[:id]
      product.destroy
      # redirect_to products_path
    # end
  end

end
