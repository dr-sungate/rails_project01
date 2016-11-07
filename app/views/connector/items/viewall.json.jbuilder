json.status 'success'
json.messages 'Success'

json.results do
  json.counts @itemcounts
  json.currentpage @currentpage
  json.totalpages @totalpages
  json.items @items do |item|
    json.item_code item.code
    json.name item.name
    json.categories do
      json.array! get_categoryarray(item)
    end
  end
end
