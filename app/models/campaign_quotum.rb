class CampaignQuotum < ActiveRecord::Base
  belongs_to :campaign
  has_many :campaign_qualifications

  def get_quota
    begin
      base_url = self.get_tap_research_base_url + "/campaigns/#{campaign_id}/campaign_quotas"
      authorization = self.get_encoded_authorization
      data = HTTParty.get(base_url,
                          headers: {"Authorization" => "#{authorization}",
                                    "Content-Type" => "application/json"})

      return data.parsed_response
    rescue => e
      return {success: false,message: e.message}
    end

  end

  def create_campaign_qualifications campaign_qualifications
    campaign_qualifications.each do |qualification|
      pre_codes = qualification["pre_codes"].join(",")
      CampaignQualification.create(campaign_quotum_id: id,
                                   question_id: qualification["question_id"],
                                   pre_codes: pre_codes
      )
    end


  end
end
