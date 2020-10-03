FactoryBot.define do
  factory :item do

    image               {"hoge.png"}
    name                {"商品"}
    introduction        {"ホワイト"}
    category_id         {"1"}
    item_condition_id   {"1"}
    postage_payer_id    {"1"}
    prefecture_code_id  {"1"}
    preparation_day_id  {"1"}
    price               {"3000"}
    brand               {"nike"}
    # seller_id           {"1"}

    # 下記はテストに必要ないので記述しない
    # Item id             {"1"}
    # trading_status    {"1"}
    # buyer_id          {"1"}
    # created_at          {"2020-09-25 14:41:43"}
    # updated_at        {"2020-09-25 14:41:43"}

  end
end
