require "kele/version"
require "httparty"
require "kele/errors"

class Kele
  include HTTParty

  def initialize(email, password)
    url = "https://www.bloc.io/api/v1/sessions"
    response = self.class.post("#{url}?email=#{email}&password=#{password}")

    raise InvalidStudentCodeError.new() if response.code == 401
    @auth_token = response["auth_token"]
  end
end
