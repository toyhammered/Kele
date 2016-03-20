require "kele/version"
require "kele/errors"
require "kele/roadmap"
require "httparty"
require "json"
require "pp"

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

  def get_roadmap
    response = self.class.get(api_url("roadmaps/#{current_enrollment['roadmap_id']}"), headers: { "authorization": @auth_token })
    @roadmap = JSON.parse(response.body)
  end

  def get_checkpoint(checkpoint_id)
    response = self.class.get(api_url("checkpoints/#{checkpoint_id}"), headers: { "authorization": @auth_token })
    @checkpoint = JSON.parse(response.body)
  end

  def get_messages(page)
    response = self.class.get(api_url("message_threads?page=#{page}"), headers: { "authorization": @auth_token })
    # count = (response['count']/10.to_f).ceil
    # not sure how to make all pages load together

    @get_messages = JSON.parse(response.body)
    pp @get_messages
  end

  def create_message(recipient_id, subject, message)
    response = self.class.post(api_url("messages"), body: { "user_id": id, "recipient_id": recipient_id, "subject": subject, "stripped-text": message }, headers: { "authorization": @auth_token })
    puts response
  end

  private

  def api_url(endpoint)
    "https://www.bloc.io/api/v1/#{endpoint}"
  end

end
