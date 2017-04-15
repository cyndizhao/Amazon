class ReviewsController < ApplicationController
  before_action :authenticate_user!
    def create
      # byebug
      @product = Product.find(params[:product_id])
      review_params = params.require(:review).permit(:body, :rating)
      @review = Review.new(review_params)
      # @review.product = @product
      @review.user = current_user

      if @review.save
        redirect_to product_path(@product), notice:'Review Created'
      else
        #redirect_to question_path(@question), alert: "Couldn't Create Answer!"
        # render '/products/show'
        redirect_to product_path(@product)
      end
    end

    def destroy
      if !(can? :destroy, @product)
        redirect_to root_path, alert:'access denied'
      else
        review = Review.find(params[:id])
        review.destroy
        redirect_to product_path(review.product), notice: "Review deleted!"
      end
    end
end
