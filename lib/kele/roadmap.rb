module Roadmap
  def get_roadmap
    response = self.class.get(api_url("roadmaps/#{current_enrollment['roadmap_id']}"), user_auth)
    @roadmap = JSON.parse(response.body)
  end

  def get_checkpoint(checkpoint_id)
    response = self.class.get(api_url("checkpoints/#{checkpoint_id}"), user_auth)
    @checkpoint = JSON.parse(response.body)
  end
end
