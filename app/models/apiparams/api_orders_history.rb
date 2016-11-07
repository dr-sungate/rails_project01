class Apiparams::ApiOrdersHistory
  include Virtus.model
  include ActiveModel::Model
  
  attribute :order_id,    String
  attribute :item_code,    String
  attribute :order_date,    Date
  attribute :account,        String
  attribute :recommend_code, String
  
  validates :order_id_or_item_code_or_order_date, presence: true
  validates :order_id, length: { maximum: 255 }
  validates :item_code, length: { maximum: 255 }
  validates :order_date, timeliness: { on_or_before: :today,    format: '%Y-%m-%d' }, allow_blank: true, length: { maximum: 255 }
  validates :account, presence: true, length: { maximum: 255 }
  validates :recommend_code, presence: true, length: { maximum: 255 }
    
  private
    def order_id_or_item_code_or_order_date
      order_id.presence or item_code.presence or order_date.presence
    end

end