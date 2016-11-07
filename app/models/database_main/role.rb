class DatabaseMain::Role < DatabaseMain::Base

  
  TYPE_ADMIN = 0
  TYPE_PROVIDER = 1
  TYPE_OWNER = 2
  TYPE_ADMIN_ACCOUNTING = 10

  has_many :users,  class_name: 'DatabaseMain::User', inverse_of: :role
  belongs_to :provider, class_name: 'DatabaseMain::User', foreign_key: 'agency_id', inverse_of: :owners_role


  def self.provider_role
    self.find_by!(role_type: TYPE_PROVIDER)
  end

  def self.get_role(type)
    self.find_by_role_type(type)
  end

  def owner?
    role_type == TYPE_OWNER
  end

  def provider?
    role_type == TYPE_PROVIDER
  end

  def admin?
    role_type == TYPE_ADMIN
  end

  def admin_accounting?
    role_type == TYPE_ADMIN_ACCOUNTING
  end

  private

  def validate_destroy
    if owner?
      unless users.empty?
        errors.add :base, 'Cannot delete owner role with owners'
        return false
      end
    end
  end

end
