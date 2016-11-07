class Oauth::OwnersController < AdminBaseController
   
  def getlist
    #@ownerlist =  DatabaseMain::User.joins("inner join roles on roles.id = users.role_id").joins("inner join users as provider on roles.agency_id = provider.id").where("provider.id =?", params[:providerid] ) 
    @ownerlist =  DatabaseMain::User.joins(:role => :provider).where(providers_roles: {id: params[:providerid]})
 #       render json: @ownerlist
    render json: @ownerlist.to_json(
      :only => [:id,:name, :label]
    )
   end
  
def getlist_withoutselected
  application_owner = ApplicationOwner.where(application_id: params[:appid])
  @ownerlist =  DatabaseMain::User.joins(:role => :provider).where(providers_roles: {id: params[:providerid]}).where.not(id: application_owner.map(&:owner_id))
  render json: @ownerlist.to_json(
    :only => [:id,:name, :label]
  )
 end
  
  
  private
 end
