require "kele/version"
require "kele/errors"
require "kele/roadmap"
require "kele/messages"
require "httparty"
require "json"
require "pp"

class Kele
  include HTTParty
  include Roadmap
  include Messages

  def initialize(email, password)
    response = self.class.post(api_url("sessions"), body: { "email": email, "password": password })

    raise InvalidStudentCodeError.new() if response.code == 401
    @auth_token = response["auth_token"]
  end

  def get_me
    response = self.class.get(api_url("users/me"), user_auth )
    @user_data = JSON.parse(response.body)
    @user_data.keys.each do |key|
      self.class.send(:define_method, key.to_sym) do
        @user_data[key]
      end
    end
    @user_data
  end

  def get_mentor_availability
    response = self.class.get(api_url("mentors/#{current_enrollment['mentor_id']}/student_availability"), user_auth)
    @mentor_availability = JSON.parse(response.body)
  end

  def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment)
    response = self.class.post(api_url("checkpoint_submissions"), :body => { "checkpoint_id" => checkpoint_id, "assignment_branch" => assignment_branch, "assignment_commit_link" => assignment_commit_link, "comment" => comment }.merge(user_auth))
  end

  def api_url(endpoint)
    "https://www.bloc.io/api/v1/#{endpoint}"
  end

  def user_auth
    {headers: {
      authorization: @auth_token
    }}
  end

end
