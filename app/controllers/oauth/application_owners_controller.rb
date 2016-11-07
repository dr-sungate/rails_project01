class Oauth::ApplicationOwnersController < AdminBaseController
  before_action :set_application_id
  before_action :set_application_owner, only: [:show, :create]
  before_action :set_ownerlist, only: [:show, :create]
  before_action :set_providers, only: [:show, :create]
  before_action :set_add_application_owner, only: [:show]
  
  def show
  end
  
  def create
    logger.debug("######")
    logger.debug(application_owner_params)
    @add_application_owner = ApplicationOwner.new(application_owner_params)

    if @add_application_owner .save
      redirect_to show_oauth_application_owners_url(@applicarioin_id), notice: 'オーナーを追加しました。'
    else
      render :show, status: :bad_request
    end
  end
  
  def destroy
    begin
      ApplicationOwner.transaction do
        ApplicationOwner.delete_all(application_id: params[:appid], owner_id: params[:ownerid])
        redirect_to show_oauth_application_owners_url(@applicarioin_id), notice: "削除しました。"
      end
    rescue =>e
      logger.error(e)
      redirect_to show_oauth_application_owners_url(@applicarioin_id), alert: '削除に失敗しました。'
    end
  end
  
  private
    
   def set_providers
     types = [[], [], []]
     DatabaseMain::User.sort_providers(DatabaseMain::User.providers.includes(:role, :owners_role)).each do |user|
       types[user.provider_type] << user
     end
     @providers = types
   end
   
    def set_application_id
      @applicarioin_id = params[:appid]
    end
    
    def set_application_owner
      @application_owner = ApplicationOwner.where(application_id: params[:appid])
    end
  
   def set_ownerlist
      if !@application_owner.nil?
       @ownerlist = DatabaseMain::User.where("id in (?)", @application_owner.map(&:owner_id))
     end
   end
   
    def set_add_application_owner
      @add_application_owner = ApplicationOwner.new
      @add_application_owner.application_id = @applicarioin_id
    end
    
    def application_owner_params
      params.require(:application_owner).permit(
        :application_id, :owner_id
      )
    end

end
