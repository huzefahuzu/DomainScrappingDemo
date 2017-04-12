class CreateDomainRanks < ActiveRecord::Migration
  def change
    create_table :domain_ranks do |t|
      t.integer :rank
      t.datetime :rank_time
      t.integer :domain_id

      t.timestamps null: false
    end
  end
end
