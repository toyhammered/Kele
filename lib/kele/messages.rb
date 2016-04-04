module Messages
  def get_messages(page)
    response = self.class.get(api_url("message_threads?page=#{page}"), user_auth)
    # count = (response['count']/10.to_f).ceil
    # not sure how to make all pages load together

    @get_messages = JSON.parse(response.body)
    pp @get_messages
  end

  def create_message(recipient_id, subject, message)
    response = self.class.post(api_url("messages"), :body => { "user_id" => id, "recipient_id" => recipient_id, "subject" => subject, "stripped-text" => message }.merge(user_auth))
    pp response
  end
end
