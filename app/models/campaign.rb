class Campaign < ActiveRecord::Base
  include Authentication

  def self.get_campaigns
    begin
      base_url = self.get_tap_research_base_url + "/campaigns"
      authorization = self.get_encoded_authorization
      data = HTTParty.get(base_url,
                          headers: {"Authorization" => "#{authorization}",
                                    "Content-Type" => "application/json"})

      return data.parsed_response
    rescue => e
      return {success: false,message: e.message}
    end

  end

  def self.import_campaigns

    campaigns = self.get_campaigns
    existing_campaign_ids = Campaign.all.map(&:campaign_id)
    
    campaigns.each do |campaign|

      Campaign.create(campaign_id: campaign["id"],
                      length_of_interview:campaign["length_of_interview"],
                      cpi: campaign["cpi"],
                      name: campaign["name"]) unless existing_campaign_ids.include?(campaign["id"])
    end

  end


end
