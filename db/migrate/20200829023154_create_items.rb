class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :img
      t.string :introduction
      t.string :category
      t.string :brand
      t.string :item_condition_id
      t.string :price
      t.string :item_condition
      t.string :prefecture_code_id
      t.string :postage_payer_id
      t.string :prefecture_code_id
      t.string :preparation_day_id
      t.timestamps
    end
  end
end


