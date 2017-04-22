class ProductsMailer < ApplicationMailer
  def notify_product_owner(product)
    @product = product
    @user = @product.user
    mail(to: @user.email, subject: 'You just createa new product!') if @user
  end
end
