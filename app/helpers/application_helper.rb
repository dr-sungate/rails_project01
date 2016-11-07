module ApplicationHelper

  def form_options(model)
    if model.new_record?
      { url: { action: 'create' }, method: :post, html: {class: 'form-horizontal', role: 'form'} }
    else
      { url: { action: 'update' }, method: :put, html: {class: 'form-horizontal', role: 'form'} }
    end
  end

end
