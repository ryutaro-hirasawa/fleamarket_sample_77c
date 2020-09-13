class ItemsController < ApplicationController
  def index
    @items = Item.includes(:images).order('created_at DESC')
  end

  def new
    @item = Item.new
    @item.images.new
  end

  def create
    @item = Item.new(product_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:item).permit(:name, :price, images_attributes: [:src])
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
