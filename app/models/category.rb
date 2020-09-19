class Category < ActiveHash::Base
  self.data = [
    {id: 1, name: 'レディース'}, {id: 2, name: 'メンズ'}
  ]
  # コミット前 プッシュ前に category.rb を必ず削除する
end