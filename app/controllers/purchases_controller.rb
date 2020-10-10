class PurchasesController < ApplicationController
  require "payjp"

  def buy
    # 購入する商品を引っ張ってきます。
    @item = Item.find(params[:item_id])
    # 商品ごとに複数枚写真を登録できるので、一応全部持ってきておきます。
    @images = @item.images.all

    # まずはログインしているか確認
    if user_signed_in?
      @user = current_user
      # クレジットカードが登録されているか確認
      if @user.card.present?
        # 前前前回credentials.yml.encに記載したAPI秘密鍵を呼び出します。
        Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
        # ログインユーザーのクレジットカード情報を引っ張ってきます。
        @card = Card.find_by(user_id: current_user.id)
        # (以下は以前のcredit_cardsコントローラーのshowアクションとほぼ一緒です)
        # ログインユーザーのクレジットカード情報からPay.jpに登録されているカスタマー情報を引き出す
        customer = Payjp::Customer.retrieve(@card.customer_id)
        # カスタマー情報からカードの情報を引き出す
        @customer_card = customer.cards.retrieve(@card.card_token)

        ##カードのアイコン表示のための定義づけ
        @card_brand = @customer_card.brand
        case @card_brand
        when "Visa"
          # 例えば、Pay.jpからとってきたカード情報の、ブランドが"Visa"だった場合は返り値として
          # (画像として登録されている)Visa.pngを返す
          @card_src = "visa.png"
        when "JCB"
          @card_src = "jcb.png"
        when "MasterCard"
          @card_src = "master.png"
        when "American Express"
          @card_src = "amex.png"
        when "Diners Club"
          @card_src = "diners.png"
        when "Discover"
          @card_src = "discover.png"
        end
        # viewの記述を簡略化
        ## 有効期限'月'を定義
        @exp_month = @customer_card.exp_month.to_s
        ## 有効期限'年'を定義
        @exp_year = @customer_card.exp_year.to_s.slice(2,3)
      else
      end
    else
      # ログインしていなければ、商品の購入ができずに、ログイン画面に移動します。
      redirect_to user_session_path, alert: "ログインしてください"
    end
  end

  def pay
    #ちなみに見やすさ考慮し、before_actionなどのリファクタリングなどはあえてしてません。
    @item = Item.find(params[:item_id])
    @images = @item.images.all

    # 購入テーブル登録ずみ商品は２重で購入されないようにする
    # (２重で決済されることを防ぐ)
    if @item.purchases.present?
      redirect_to item_path(@item.id), alert: "売り切れています。"
    else
      # 同時に2人が同時に購入し、二重で購入処理がされることを防ぐための記述
      @item.with_lock do
        if current_user.card.present?
          # ログインユーザーがクレジットカード登録済みの場合の処理
          # ログインユーザーのクレジットカード情報を引っ張ってきます。
          @card = Card.find_by(user_id: current_user.id)
          # 前前前回credentials.yml.encに記載したAPI秘密鍵を呼び出します。
          Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
          #登録したカードでの、クレジットカード決済処理
          charge = Payjp::Charge.create(
          # 商品(item)の値段を引っ張ってきて決済金額(amount)に入れる
          amount: @item.price,
          customer: Payjp::Customer.retrieve(@card.customer_id),
          currency: 'jpy'
          )
        else
          # ログインユーザーがクレジットカード登録されていない場合(Checkout機能による処理を行います)
          # APIの「Checkout」ライブラリによる決済処理の記述
          Payjp::Charge.create(
          amount: @item.price,
          card: params['payjp-token'], # フォームを送信すると作成・送信されてくるトークン
          currency: 'jpy'
          )
        end
      #購入テーブルに登録処理(今回の実装では言及しませんが一応、、、)
      @purchase = Purchase.create(user_id: current_user.id, item_id: params[:item_id])
      end
    end
  end
end
