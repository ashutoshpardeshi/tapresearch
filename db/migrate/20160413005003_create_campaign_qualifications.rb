class CreateCampaignQualifications < ActiveRecord::Migration
  def change
    create_table :campaign_qualifications do |t|
      t.references :campaign_quotum, index: true, foreign_key: true
      t.integer :question_id
      t.text :pre_codes

      t.timestamps null: false
    end
    add_index :campaign_qualifications, :question_id
  end
end
