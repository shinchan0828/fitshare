class InquiriesController < ApplicationController
  def new
  end
  
  def create
    @inquiry = Inquiry.new(inquiry_params)
    @inquiry.save
    redirect_to new_inquiry_path
  end
  
   private

   def inquiry_params
     params.require(:inquiry).permit(:name, :email, :content)
   end
end
