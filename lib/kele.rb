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
    response = self.class.get(api_url("users/me"), headers: { "authorization": @auth_token } )
    @user_data = JSON.parse(response.body)
    @user_data.keys.each do |key|
      self.class.send(:define_method, key.to_sym) do
        @user_data[key]
      end
    end
  end

  def get_mentor_availability
    response = self.class.get(api_url("mentors/#{current_enrollment['mentor_id']}/student_availability"), headers: { "authorization": @auth_token })
    @mentor_availability = JSON.parse(response.body)

  end


  private

  def api_url(endpoint)
    "https://www.bloc.io/api/v1/#{endpoint}"
  end

end
