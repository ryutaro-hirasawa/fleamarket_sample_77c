class ItemsController < ApplicationController

  before_action :set_item, except: [:index, :new, :create, :category_children, :category_grandchildren]


  def index
    @item = Item.includes(:images).order('created_at DESC')
    @items = Item.all
  end

  def new
    @item = Item.new
    @category_parent =  Category.where("ancestry is null")
    @item.images.new
  end

  # 親カテゴリーが選択された後に動くアクション
  def category_children
    @category_children = Category.find("#{params[:parent_id]}").children
    #親カテゴリーに紐付く子カテゴリーを取得
  end

  # 子カテゴリーが選択された後に動くアクション
  def category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
    #子カテゴリーに紐付く孫カテゴリーの配列を取得
  end

  def create
    @item = Item.new(item_params)
    @category_parent =  Category.where("ancestry is null")
    
    if @item.save
      flash[:notice] = '出品を完了しました'
      redirect_to root_path
    else
      flash.now[:alert] = '出品に失敗しました'
      render :new
    end
  end

  def show
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      flash[:notice] = '削除完了しました'
      redirect_to root_path
    else
      flash.now[:alert] = '削除に失敗しました'
      redirect_to root_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :category_id, :brand, :item_condition_id, :postage_payer_id, :prefecture_code_id, :preparation_day_id, :price, images_attributes:  [:src, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
