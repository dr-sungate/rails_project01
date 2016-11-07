class DatabaseMain::Tax < DatabaseMain::Base



  def self.get_current_rate(date = nil)
    if !date.nil?
      currentdate = date.to_time.to_datetime
    else
      currentdate = DateTime.now
    end
    tax = self.where('start_at < ?',  currentdate).order(start_at: :desc).first
    tax.tax_rate
  end
end
