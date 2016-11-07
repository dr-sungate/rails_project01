class ApplicationOwner < ApplicationRecord
  
  validates :application_id, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :owner_id, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    
    def self.check_owner(application_id,  owner_id)
      count = self.where(application_id: application_id, owner_id: owner_id).count 
      (count > 0)
    end
end
