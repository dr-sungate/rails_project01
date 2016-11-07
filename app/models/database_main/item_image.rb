class DatabaseMain::ItemImage < DatabaseMain::Base

  belongs_to :item , class_name: 'DatabaseMain::Item'

end

