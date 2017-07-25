require 'httparty'
require 'json'

module Message
    include HTTParty
    
    
    def get_messages(page = nil)
        if page.nil?
            response = self.class.get("#{@base_uri}/message_threads", headers: { "authorization" => @auth_token })
        else
            response = self.class.get("#{@base_uri}/message_threads?page=#{page}", headers: { "authorization" => @auth_token })
        end
        
        @messages = JSON.parse(response.body)
    end
    
    def create_message(sender_email, recipient_id, subject, message)
        response = self.class.post("#{@base_uri}/messages",
        query: {
            "sender": sender_email,
            "recipient_id": recipient_id,
            "subject": subject,
            "stripped-text": message
        }, headers: { "authorization" => @auth_token })
        
        p response
    end

end