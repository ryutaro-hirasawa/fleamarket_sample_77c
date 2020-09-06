class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.introduntion :text
      t.price :integer
      t.brand :text
      t.item_condition_id :integer
      t.postage_payer_id :integer
      t.prefecture_code_id :integer
      t.preparation_day_id :integer
      t.category :references
      t.trading_status :integer
      t.seller :references	
      t.buyer :references
      t.timestamps
    end
  end
end
