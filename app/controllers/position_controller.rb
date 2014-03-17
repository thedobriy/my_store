class PositionController < ApplicationController

  private
  
  def user_params
    params.require(:position).permit(:item_id, :cart_id, :quantity)
  end
  
end
