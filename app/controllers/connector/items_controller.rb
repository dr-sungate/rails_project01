class Connector::ItemsController < Connector::ConnectorBaseController
  skip_before_action :require_logined
  before_action :doorkeeper_authorize!
  before_action :check_viewpatrams, only: [:view]
  before_action :check_viewallpatrams, only: [:viewall]
  before_action :check_categorypatrams, only: [:category]
  before_action :set_user, only: [:category, :view, :viewall]
  before_action :check_user, only: [:category, :view, :viewall]
  before_action :set_recommend, only: [:category, :view, :viewall]
  after_action :apirequest_logger
  respond_to :json

  def category
    if !@recommend.nil?
      @param_category_code =  params[:category_code]
      @items = @recommend.active_items.where("category = ? or options like ? or options like ?", params[:category_code], "%category_" + params[:category_code] + "%", "%" + params[:category_code] + "%")
     end
  end 
  
  def view
    logger.debug(doorkeeper_token.application_id)
    if !@recommend.nil?
      @item = @recommend.active_items.find_by_code(params[:item_code]) 
    end
    if @item.nil?
      handle_error_response("No valid Item")
    end
  end

  def viewall
    logger.debug(doorkeeper_token.application_id)
    if !@recommend.nil?
      @currentpage=params[:page]
      @itemcounts = @recommend.active_items.count
      @totalpages=@itemcounts/RECOMMEND2_ROWLIMIT.to_i
      @totalpages += 1 if (@itemcounts % RECOMMEND2_ROWLIMIT ) > 0
      @items = @recommend.active_items.order(id: :desc).limit(RECOMMEND2_ROWLIMIT).offset((params[:page].to_i - 1)*RECOMMEND2_ROWLIMIT)
    end
    if @items.nil?
      handle_error_response("No valid Item")
    end
  end
  
  private
  
  def check_viewpatrams
    apiinputmodel = Apiparams::ApiItemsView.new(view_params)
    if !apiinputmodel.valid?
      handle_error_response(convert_validationmessage(apiinputmodel.errors))
    end
  end

  def check_viewallpatrams
    apiinputmodel = Apiparams::ApiItemsViewall.new(viewall_params)
    if !apiinputmodel.valid?
      handle_error_response(convert_validationmessage(apiinputmodel.errors))
    end
  end

    
  def view_params
   params.permit(:item_code,:account,:recommend_code)
  end

  def viewall_params
   params.permit(:page,:account,:recommend_code)
  end
  
  def check_categorypatrams
    apiinputmodel = Apiparams::ApiItemsCategory.new(category_params)
    if !apiinputmodel.valid?
      logger.error(apiinputmodel.errors.messages)
      handle_error_response(convert_validationmessage(apiinputmodel.errors))
    end
  end
  
  def category_params
   params.permit(:category_code,:account,:recommend_code)
  end
  
end
