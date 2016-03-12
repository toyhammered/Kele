require "kele/version"
require "kele/errors"
require "httparty"
require "json"

class Kele
  include HTTParty

  def initialize(email, password)
    response = self.class.post(api_url("sessions"), body: { "email": email, "password": password })

    raise InvalidStudentCodeError.new() if response.code == 401
    @auth_token = response["auth_token"]
  end

  def get_me
    response = self.class.get(api_url("users/me"), headers: { "authorization": @auth_token })
    @user_data = JSON.parse(response.body)

  end


  private

  def api_url(endpoint)
    "https://www.bloc.io/api/v1/#{endpoint}"
  end

end
