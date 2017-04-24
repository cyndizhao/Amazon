class VotesController < ApplicationController
  before_action :authenticate_user!
  # TODO: build and enforce permissions for the actions in this controller

  def create
    review = Review.find(params[:review_id])
    vote = Vote.new(is_up: params[:is_up], user: current_user, review: review)
    if cannot? :vote, review
      redirect_to product_path(review.product), alert: 'Vote your own review is not permitted'
      return
    end
    if vote.save
      redirect_to product_path(review.product), notice: 'Review Voted!'

    else
      redirect_to product_path(review.product), alert: vote.errors.full_messages(',')
    end
  end

  def update
    vote = Vote.find params[:id]
    vote.is_up = params[:is_up]
    if cannot? :vote, vote.review
      redirect_to product_path(vote.review.product), alert: 'Update your own review is not permitted'
      return
    end
    if vote.save
      redirect_to product_path(vote.review.product), notice: 'Review Vote Updated'
    else
      redirect_to product_path(vote.review.product), alert: vote.errors.full_messages.join(", ")
    end
  end

  def destroy
    vote = Vote.find params[:id]
    if cannot? :vote, vote.review
      redirect_to product_path(vote.review.product), alert: 'UnVote your own review is not permitted'
      return
    end
    vote.destroy
    redirect_to product_path(vote.review.product), notice: 'Vote removed'
  end
end
