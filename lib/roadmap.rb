require 'httparty'
require 'json'

module Roadmap
    include HTTParty
    
    def get_roadmap(roadmap_id)
        response = self.class.get("#{@base_uri}/roadmaps/#{roadmap_id}", headers: { "authorization" => @auth_token })
        @roadmap = JSON.parse(response.body)
    end
    
    def get_checkpoint(checkpoint_id)
        response = self.class.get("#{@base_uri}/checkpoints/#{checkpoint_id}", headers: { "authorization" => @auth_token })
        @checkpoint = JSON.parse(response.body)
    end
    
    def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment, enrollment_id)
        response = self.class.post("#{@base_uri}/checkpoint_submissions",
        body: {
            "assignment_branch": assignment_branch,
            "assignment_commit_link": assignment_commit_link,
            "checkpoint_id": checkpoint_id,
            "comment": comment,
            "enrollment_id": enrollment_id
        }, headers: { "authorization" => @auth_token })
        p response
    end
    
end