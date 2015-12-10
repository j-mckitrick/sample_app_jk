class CreateDeveloperProfiles < ActiveRecord::Migration
  def change
    create_table :developer_profiles do |t|
      t.integer :user_id
      t.string :employment
      t.string :experience
      t.string :yearly_projects
      t.string :typical_project_size
      t.string :how_did_you_hear
      t.string :how_response
      t.string :why
      t.string :state

      t.timestamps
    end
  end
end
