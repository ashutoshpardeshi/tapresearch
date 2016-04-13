class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.integer :campaign_id
      t.string :name
      t.integer :length_of_interview
      t.float :cpi

      t.timestamps null: false
    end
    add_index :campaigns, :name
    add_index :campaigns, :campaign_id
  end
end
