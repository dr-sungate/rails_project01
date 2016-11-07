class Admin::AdminusersController < AdminBaseController
  before_action :set_adminuserlist, only: [:index]
  before_action :set_adminuser, only: [:edit, :update, :destroy]
    
  def index
    
  end
  
  def new
    @adminuser = User.new
  end
  
  def create
   @adminuser = User.new(adminuser_params)
    @adminuser.admin = true
    if @adminuser.save
      redirect_to admin_adminusers_url, notice: '追加しました。'
    else
      render :new, status: :bad_request
    end
  end
  
  def edit
  end
  
  def update
    if @adminuser.update_with_password(adminuser_params)
      redirect_to admin_adminusers_url, notice: '変更しました。'
    else
      render :edit, status: :bad_request
    end
    
  end
  
  def destroy
    if @adminuser.destroy
      redirect_to admin_adminusers_url, notice: '削除しました。'
    else
      redirect_to admin_adminusers_url, notice: '削除に失敗しました。！！！'
    end
   
  end
  
  private
  
  def set_adminuserlist
     @adminusers = User.where(admin: true).order(created_at: :desc)
  end
  
  def set_adminuser
    @adminuser = User.find_by!(id:params[:id])
  end
  
  def adminuser_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  


end
