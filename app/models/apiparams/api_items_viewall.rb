class Apiparams::ApiItemsViewall
  include Virtus.model
  include ActiveModel::Model
  
  attribute :page,    String
  attribute :account,        String
  attribute :recommend_code, String
  
  validates :page, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than: 10000000 }
  validates :account, presence: true, length: { maximum: 255 } 
  validates :recommend_code, presence: true, length: { maximum: 255 } 
end