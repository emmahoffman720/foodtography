class VariationsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @post = Post.find_by_id(params[:post_id])
    return render_not_found if @post.blank?
    @post.variations.create(variation_params.merge(user: current_user))
    redirect_to root_path
  end
  
  private


  
  def variation_params
    params.require(:variation).permit(:title, :description, :recipe)
  end
end
