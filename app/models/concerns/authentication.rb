require 'base64'
module Authentication
  extend ActiveSupport::Concern

  module ClassMethods
    #guessing this will be coming from a table, possible user
    def get_tap_research_base_url
      "https://staging.tapresearch.com/api/v1"
    end

    def get_email
      "codetest@tapresearch.com"
    end

    def get_token
      "76b2ef0268a9177927a95bd4db4b8dbc"
    end

    def get_encoded_authorization
      base_string = get_email + ':' + get_token
      return   "Basic" + Base64.encode64(base_string).to_s
    end
  end
end