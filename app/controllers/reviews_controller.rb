class ReviewsController < ApplicationController

  before_action :require_login

  def create
    product = Product.find(params[:product_id])

    if params[:review][:rating] == ""
      redirect_to product_path(product.id)
    else
      product.reviews.create!(description: params[:review][:description], rating: params[:review][:rating], user: current_user)

      redirect_to product_path(product.id)

    end

  end

  def destroy
    @review = Review.find params[:id]

    if @review.user == current_user
      @review.destroy
      redirect_to product_path(params[:product_id]), notice: 'Product deleted!'
    else
      redirect_to product_path(params[:product_id])
    end
  end

  private
    def require_login
      unless current_user
        redirect_to login_path
      end
    end

end
