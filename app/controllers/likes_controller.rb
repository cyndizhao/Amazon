class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    review = Review.find(params[:review_id])
    like = Like.new(user: current_user, review: review)
    if cannot? :like, review
      redirect_to product_path(review.product), alert: 'liking your own review is disgusting'
      return
    end
    if like.save
      redirect_to product_path(review.product), notice: 'Review liked!'

    else
      redirect_to product_path(review.product), alert: like.errors.full_messages(',')
    end
  end

  def destroy
    like = Like.find(params[:id])
    if cannot? :like, like.review
      redirect_to product_path(like.review.product), alert: 'Can not Unliking your own review'
      return
    end

    if like.destroy
      redirect_to product_path(like.review.product), notice:'Un-liked review!'
    else
      redirect_to product_path(like.review.product), alert: like.errors.full_messages.join(', ')
    end
  end

end
