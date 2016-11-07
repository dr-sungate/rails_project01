class DatabaseMain::User < DatabaseMain::Base
  
  STATUS_DISABLED = 0
  STATUS_ENABLED = 1

  PROVIDER_TYPE_DIRECT = 0
  PROVIDER_TYPE_OEM = 1
  PROVIDER_TYPE_AGENCY = 2
 
  DIRECT_PROVIDER_NAMES = PROVIDER_CONFIG['direct_provider']['names']
  OEM_PROVIDER_NAMES = PROVIDER_CONFIG['oem_provider']['names']
    
  DIRECT_BILL_ON_DATE = PROVIDER_CONFIG['direct_provider']['bill_on_date']
  OEM_BILL_ON_DATE = PROVIDER_CONFIG['oem_provider']['bill_on_date']
  AGENCY_BILL_ON_DATE = PROVIDER_CONFIG['agency_provider']['bill_on_date']

  FUTURESHOP_API_PASSWORD = PROVIDER_CONFIG['futureshop_api_password']
 
  belongs_to :role,  class_name: 'DatabaseMain::Role'
  has_one :owners_role,  class_name: 'DatabaseMain::Role', foreign_key: 'agency_id', inverse_of: :provider, dependent: :destroy
  has_many :owners, through: :owners_role, source: :users

  scope :providers, -> { joins("inner join roles on roles.id = users.role_id").where("roles.role_type =?",  DatabaseMain::Role::TYPE_PROVIDER ) }
  scope :owners, -> { joins("inner join roles on roles.id = users.role_id").where("roles.role_type =?",  DatabaseMain::Role::TYPE_OWNER ) }
#  scope :owners, -> { joins { role }.where { role.role_type == DatabaseMain::Role::TYPE_OWNER } }

  def self.sort_providers(users)
    users.sort_by {|user|
      [user.provider_type, user.label.downcase.tr('ぁ-ん','ァ-ン')]
    }
  end
  
  
def provider_type
   return nil unless role.provider?
   if DIRECT_PROVIDER_NAMES.include? name
     PROVIDER_TYPE_DIRECT
   elsif OEM_PROVIDER_NAMES.include? name
     PROVIDER_TYPE_OEM
   else
     PROVIDER_TYPE_AGENCY
   end
 end


end