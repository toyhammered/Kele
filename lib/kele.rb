require "kele/version"
require "httparty"

class Kele
  include HTTParty

  def initialize(email, password)
    # auth_token = response["auth_token"]
    # url = "https://www.bloc.io/api/v1/sessions"
    # response = self.class.post("#{url}?email=#{email}&password=#{password}")
  end
end
