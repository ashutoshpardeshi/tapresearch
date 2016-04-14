class CampaignsController < ApplicationController


  def ordered_campaigns

    @campaign_list, @gender_data = Campaign.get_ordered_list

  end

end
