class CampaignsController < ApplicationController

  def index

    @campaigns = Campaign.get_campaigns


  end

end
