class CreateCampaignQuota < ActiveRecord::Migration
  def change
    create_table :campaign_quota do |t|
      t.references :campaign, index: true, foreign_key: true
      t.string :name
      t.integer :num_respondents

      t.timestamps null: false
    end
    add_index :campaign_quota, :name
  end
end
