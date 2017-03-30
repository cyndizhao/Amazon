class ContactController < ApplicationController
  def index

  end

  def create
    @name = params[:name]
    # render plain: "Thank you #{@name} for contact us!"
    redirect_to contact_path({user: params[:name]})
  end
end
