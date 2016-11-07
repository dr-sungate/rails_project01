class Apiparams::ApiItemsCategory
  include Virtus.model
  include ActiveModel::Model
  
  attribute :category_code,    String
  attribute :account,        String
  attribute :recommend_code, String
  
  validates :category_code, presence: true, length: { maximum: 255 }
  validates :account, presence: true, length: { maximum: 255 }
  validates :recommend_code, presence: true, length: { maximum: 255 }
end