module Connector::ItemsHelper
  
  def get_categoryarray(item)
    returnarr = {}
    returnarr[item.category] = 1
    begin
      (item.options || {}).each do |column, value|
        if !value.blank?&& column.start_with?("category_")
          returnarr[column.gsub("category_", "")] = 1
        elsif !value.blank?&& column.include?("category")
          returnarr[value] = 1
        end
      end
    rescue =>e
      logger.error(e)
    end
    return returnarr.keys()
  end
end
