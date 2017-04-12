class CreateGeneralConfigs < ActiveRecord::Migration
  def change
    create_table :general_configs do |t|
      t.integer :domain_limit
      t.string :cron_time

      t.timestamps null: false
    end
  end
end
