class CreateApirequestLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :apirequest_logs, id: :bigint do |t|
      t.datetime :request_date
      t.integer :application_id
      t.string :ipaddress
      t.string :request_class
      t.string :request_method

      t.timestamps
    end
  end
end
