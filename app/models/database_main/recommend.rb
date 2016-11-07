class DatabaseMain::Recommend < DatabaseMain::Base

  ##
  # Constants

  STATUS_DISABLED = 0
  STATUS_ENABLED = 1

  DETAILED_STATUS_TRIAL = 0
  DETAILED_STATUS_WILL_ACTIVE = 1
  DETAILED_STATUS_ACTIVE = 2
  DETAILED_STATUS_WILL_CLOSE = 3
  DETAILED_STATUS_CLOSE = 4


  ##
  # Relations

  belongs_to :user,  class_name: 'DatabaseMain::User', foreign_key: 'owner_id', inverse_of: :recommends

  has_many :items,  class_name: 'DatabaseMain::Item', :dependent => :destroy
  has_many :active_items, -> { where(disabled: false) },  class_name: 'DatabaseMain::Item'

 
   ##
  # Accessors

  def detailed_status
    if contract
      if contract.status == Contract::STATUS_READY
        contract.trial ? DETAILED_STATUS_TRIAL : DETAILED_STATUS_WILL_ACTIVE
      elsif contract.status == Contract::STATUS_ACTIVE
        contract.closed_on ? DETAILED_STATUS_WILL_CLOSE : DETAILED_STATUS_ACTIVE
      else
        DETAILED_STATUS_CLOSE
      end
    else
      if status == STATUS_DISABLED || user.status == User::STATUS_DISABLED
        DETAILED_STATUS_CLOSE
      else
        DETAILED_STATUS_ACTIVE
      end
    end
  end



  ##
  # Methods override

  # use name for url
  def to_param
    name
  end

  def count_current_items
  self.items.where(
      "disabled = ? AND name != ?",
      false,
      ''
  ).count
end

def count_current_categories
  self.items.select("DISTINCT(category)").where(
      "disabled = ?  AND name != ? AND category != ?",
      false,
      '',
      ''
  ).count
end

  private


end
