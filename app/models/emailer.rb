class Emailer < ActionMailer::Base
  
def contact(recipient, subject, message, sent_at = Time.now)
      @subject = subject
      @recipients = recipient
      @from = 'maximummaxx88@gmail.com'
      @sent_on = sent_at
	  @body["title"] = 'This is title'
  	  @body["email"] = 'maximummaxx@mail.ru'
   	  @body["message"] = message
      @headers = {content_type => 'text/html'}
   end

 
end
