namespace :campaigns do
  desc "imports campaigns data"
  task import_campaigns_data: :environment do
    data = Campaign.import_campaigns
  end

end
