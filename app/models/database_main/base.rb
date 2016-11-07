class DatabaseMain::Base < ActiveRecord::Base

  establish_connection "#{Rails.env}_database".to_sym
  self.abstract_class = true
 end
