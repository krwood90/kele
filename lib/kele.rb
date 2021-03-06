require 'httparty'
require 'json'
require "./lib/roadmap"
require "./lib/message"

class Kele
    include HTTParty
    include JSON
    include Roadmap
    include Message

    def initialize(email, password)
        @base_uri = "https://www.bloc.io/api/v1"
        response = self.class.post("#{@base_uri}/sessions", body: {email: email, password: password})
        p response.code
        
        raise "Invalid email or password" unless response.code == 200
        
        @auth_token = response['auth_token']
    end
    
    def get_me
        response = self.class.get("#{@base_uri}/users/me", headers: { "authorization" => @auth_token })
        @parse_user = JSON.parse(response.body)
    end
    
    def get_mentor_availability(mentor_id)
        response = self.class.get("#{@base_uri}/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token })
        @mentor_availability = JSON.parse(response.body)
    end

end