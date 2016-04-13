class CampaignsController < ApplicationController

  def index
    @campaigns = Campaign.get_campaigns

  end

  def ordered_campaigns
    
  end

end
