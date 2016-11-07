require 'net/http'
require 'uri'
require 'rexml/document'
#require 'common/config'
# rails will fail to resolve
require 'database_main/item_data_storable'

class DatabaseMain::Item < DatabaseMain::Base
  include ItemDataStorable

  serialize :options, Hash
  belongs_to :recommend,  class_name: 'DatabaseMain::Recommend'

  has_one :item_image,  class_name: 'DatabaseMain::ItemImage'

  def label
    name.blank? ? code : name
  end

  def has_category_in_options(categorycode)
     begin
      (self.options || {}).each do |column, value|
        if column  == "category_#{categorycode}" && !value.blank? 
         return true
        elsif  !value.blank?  &&  value == categorycode
          return true
        end
      end
      return false
    rescue =>e
      logger.error(e)
    end
  end
  
end
