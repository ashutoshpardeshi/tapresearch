class Campaign < ActiveRecord::Base
  include Authentication


  def self.get_campaigns
    begin
      base_url = self.get_tap_research_base_url + "/campaigns"
      authorization = self.get_encoded_authorization
      data = HTTParty.get(base_url,
                          headers: {"Authorization" => "token #{authorization}",
                                    "Content-Type" => "application/json"})
      puts base_url
      puts authorization
      puts data.inspect
    rescue => e
      return {success: false,message: e.message}
    end

  end

  def self.save_campaigns

  end


end
