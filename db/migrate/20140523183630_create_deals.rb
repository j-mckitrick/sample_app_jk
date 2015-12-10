class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.integer :user_id
      t.string :state
      t.string :capital_type
      t.string :close_timeline
      t.string :name
      t.string :short_description
      t.money :amount_to_raise
      t.integer :followers_count, default: 0

      t.timestamps
    end
  end
end
