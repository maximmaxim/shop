# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.2.3' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

#ActionMailer::Base.delivery_method = :smtp 
#ActionMailer::Base.smtp_settings = {
#   :address => "smtp.gmail.com",
#   :port => 25,
#   :domain => "localhost",
#   :authentication => "maximummaxx88@gmail.com",
#   :user_name => "maximummaxx",
#   :password => "mail5570036",
#}
#ActionMailer::Base.default_content_type = "text/html"




Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  # See Rails::Configuration for more options.

  # Skip frameworks you're not going to use. To use Rails without a database
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Specify gems that this application depends on. 
  # They can then be installed with "rake gems:install" on new installations.
  # You have to specify the :lib option for libraries, where the Gem name (sqlite3-ruby) differs from the file itself (sqlite3)
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"

  # Only load the plugins named here, in the order given. By default, all plugins 
  # in vendor/plugins are loaded in alphabetical order.
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Make Time.zone default to the specified zone, and make Active Record store time values
  # in the database in UTC, and return them converted to the specified local zone.
  # Run "rake -D time" for a list of tasks for finding time zone names. Comment line to use default local time.
  config.time_zone = 'UTC'
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
   :address => "smtp.gmail.com",
   :port => "587",
   :domain => "localhost.localdomain",
   :authentication => :plain,
   :user_name => "maximummaxx88@gmail.com",
   :password => "mail5570036"
}
 
 # config.action_mailer.raise_delivery_errors = false
 # config.action_mailer.delivery_method = :smtp
   config.action_mailer.default_content_type = "text/html"
 # config.action_mailer.default_url_options = { :host =>
#"domainname.com" }
#  config.action_mailer.smtp_settings = {
#    :tls              => true,
#    :address          => "smtp.gmail.com",
#    :port             => 587,
#    :domain           => "domainname.com",
#    :authentication   => :plain,
#    :user_name        => "username",
#    :password         => "password"
 # }



  # The internationalization framework can be changed to have another default locale (standard is :en) or more load paths.
  # All files from config/locales/*.rb,yml are added automatically.
  # config.i18n.load_path << Dir[File.join(RAILS_ROOT, 'my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de

  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random, 
  # no regular words or you'll be exposed to dictionary attacks.
  config.action_controller.session = {
    :session_key => '_shop_session',
    :secret      => 'd3913844407dabf313d3f76c2572c87cd6c9f8d9bcae17a4da9e57f4ad29332a7240e9e03925623747d0f1398500b34ed03fea06f8c1ab6fda8484628054eace'
  }

  # Use the database for sessions instead of the cookie-based default,
  # which shouldn't be used to store highly confidential information
  # (create the session table with "rake db:sessions:create")
   config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # Please note that observers generated using script/generate observer need to have an _observer suffix
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
end
