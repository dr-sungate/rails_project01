class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
 ## has_secure_password
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
 after_create :update_uid!
  
 validates :name, presence: true  
 validates :email, presence: true, email: true

  
    def update_uid!
      update(uid: id)
    end

  def update_with_password(params, *options)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    update_attributes(params, *options)
  end    
end
