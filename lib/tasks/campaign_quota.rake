namespace :campaign_quota do
  desc "imports campaign quota data for campaigns"
  task import_campaign_quota: :environment do
    campaigns = Campaign.all

    campaigns.each do |campaign|
      begin

        campaign.create_quota
      rescue => e
        puts "Error = #{e.message}"
      end

    end

  end

end
