require 'rails_helper'

describe Item do
  
  # item = Item.new(name: "商品", introduction: "ホワイト", category_id: "1", item_condition_id: "1", postage_payer_id: "1", prefecture_code_id: "1", preparation_day_id: "1", price: "3000",)
  before do 
    @item = FactoryBot.build(:item)
  end

  describe '#create' do

    it  "name と introduction, category_id, item_condition_id, postage_payer_id, prefecture_code_id, preparation_day_id, price があれば登録できること" do
      @item.images.new(src: "test.jpeg")
      expect(@item).to be_valid
    end

    it "nameがない場合は登録できないこと" do
      @item.name = nil
      @item.valid?
      expect(@item.errors[:name]).to include("can't be blank")
    end

    it "introductionがない場合は登録できないこと" do
      item = build(:item, introduction: nil)
      item.valid?
      expect(item.errors[:introduction]).to include("can't be blank")
    end

    it "category_id がない場合は登録できないこと" do
      item = build(:item, category_id: nil)
      item.valid?
      expect(item.errors[:category_id ]).to include("can't be blank")
    end

    it "item_condition_id がない場合は登録できないこと" do
      item = build(:item, item_condition_id: nil)
      item.valid?
      expect(item.errors[:item_condition_id ]).to include("can't be blank")
    end

    it "postage_payer_id がない場合は登録できないこと" do
      item = build(:item, postage_payer_id: nil)
      item.valid?
      expect(item.errors[:postage_payer_id ]).to include("can't be blank")
    end

    it "prefecture_code_id がない場合は登録できないこと" do
      item = build(:item, prefecture_code_id: nil)
      item.valid?
      expect(item.errors[:prefecture_code_id ]).to include("can't be blank")
    end

    it "preparation_day_id がない場合は登録できないこと" do
      item = build(:item, preparation_day_id: nil)
      item.valid?
      expect(item.errors[:preparation_day_id ]).to include("can't be blank")
    end

    it "price がない場合は登録できないこと" do
      item = build(:item, price: nil)
      item.valid?
      expect(item.errors[:price ]).to include("can't be blank")
    end

  end
end

# RSpec.describe Item, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"

# end
