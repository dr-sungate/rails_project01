json.status 'success'
json.messages 'Success'

json.results do
   json.items @items do |item|
    if (!item.category.nil? && item.category == @param_category_code) || item.has_category_in_options(@param_category_code)
    json.item_code item.code
    json.name item.name
    json.categories do
      json.array! get_categoryarray(item)
    end
    end
  end
end
