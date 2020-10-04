class UsersController < ApplicationController
  def show
    @items = Item.where(seller_id: current_user.id)
  end
end
