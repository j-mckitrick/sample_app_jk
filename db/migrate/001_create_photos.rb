class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :deal_id
      t.string :description
      t.string :content_type
      t.string :filename
      t.binary :binary_data

      t.timestamps
    end
  end
end
