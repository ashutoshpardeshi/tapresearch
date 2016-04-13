class CampaignsController < ApplicationController


  def ordered_campaigns

    @campaign_list = Campaign.get_ordered_list

    puts @campaign_list.inspect


  end

end
