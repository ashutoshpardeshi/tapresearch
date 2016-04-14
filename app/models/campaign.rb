class Campaign < ActiveRecord::Base
  include Authentication

  has_many :campaign_quota


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

  def get_quota
    begin
      base_url = self.class.get_tap_research_base_url + "/campaigns/#{campaign_id}/"
      authorization = self.class.get_encoded_authorization

      data = HTTParty.get(base_url,
                          headers: {"Authorization" => "#{authorization}",
                                    "Content-Type" => "application/json"})

      return data.parsed_response
    rescue => e
      return {success: false,message: e.message}
    end

  end

  def create_quota
    response = get_quota

    quotas = response["campaign_quotas"]

    quotas.each do |quota|
      quotum = CampaignQuotum.create(num_respondents:quota["num_respondents"], campaign_id: id)
      qualification = quotum.create_campaign_qualifications(quota["campaign_qualifications"])

    end

  end

  def self.get_ordered_list

     campaign_data = Campaign.joins("LEFT JOIN campaign_quota ON campaigns.id = campaign_quota.campaign_id").joins("LEFT JOIN campaign_qualifications ON campaign_quota.id = campaign_qualifications.campaign_quotum_id").select("campaign_qualifications.question_id, campaigns.name").order("campaigns.cpi DESC, campaigns.length_of_interview ASC")
     list = {}
     arr = []
     campaign_data.each do |data|

       if list.has_key?(data.question_id)
         list[data.question_id] << data.name
       else
         list[data.question_id] = [data.name]
       end

     end
    puts list.inspect
    return list
  end





end
