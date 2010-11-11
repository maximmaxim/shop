class Notifier < ActionMailer::Base

  default_url_options[:host] = "localhost:3000"  
  default_content_type = "text/plain"   


  def user_confirmation(order, item)
    from        "shop.confirmation88@gmail.com" 
    subject    "confirmation of your's purchasing"
    sent_on       Time.now 
    recipients  order.mail
    body :order => order, :item=> item
  end
  

  def admin_confirmation(user)
    subject    'Notifier#admin_confirmation'
    recipients ''
    from       ''
    sent_on    sent_at
    body       :greeting => 'Hi,'
  end

end
