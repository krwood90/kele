require 'httparty'
require 'json'
require "./lib/roadmap"

class Kele
    include HTTParty
    include JSON
    include Roadmap

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
    
    def get_messages(page = nil)
        if page.nil?
            response = self.class.get("#{@base_uri}/message_threads", headers: { "authorization" => @auth_token })
        else
            response = self.class.get("#{@base_uri}/message_threads?page=#{page}", headers: { "authorization" => @auth_token })
        end
        
        @messages = JSON.parse(response.body)
    end
    
    def create_message(user_id, recipient_id, token=nil, subject, message)
        response = slef.class.get("#{@base_uri}/messages",
        body: {
            "user_id": user_id,
            "recipient_id": recipient_id,
            "token": token,
            "subject": subject,
            "stripped_text": message
        }, headers: { "authorization" => @auth_token })
        
        p response
    end
end