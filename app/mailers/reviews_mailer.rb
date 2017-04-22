class ReviewsMailer < ApplicationMailer
  def notify_product_owner_new_review(review)
    @review = review
    @product = @review.product
    @user = @product.user
    mail(to: @user.email, subject: 'You just got a new review for your product') if @user
  end
end
