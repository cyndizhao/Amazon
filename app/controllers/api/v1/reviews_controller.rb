class Api::V1::ReviewsController < Api::BaseController
  # before_action :authenticate_user!

  def create
    product = Product.find (params[:product_id])
    review = Review.new review_params
    review.product = product
    review.user = @user
    if review.save
      render json: {review: review, status: :success}
    else
      render json: {error: review.errors.full_messages.join(', ')}
    end
  end

  private
  def review_params
    params.require(:review).permit(:body, :rating)
  end
end
