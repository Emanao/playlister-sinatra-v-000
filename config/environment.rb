ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

# require_all 'app'
# require_all 'lib'

require_relative "../app/controllers/application_controller.rb"
require_relative "../app/controllers/artists_controller.rb"
require_relative "../app/controllers/genres_controller.rb"
require_relative "../app/controllers/songs_controller.rb"
# Dir[File.join(File.dirname(__FILE__), "../app/controllers", "*.rb")].sort.each {|f| require f}

Dir[File.join(File.dirname(__FILE__), "../app/models/concerns", "*.rb")].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}

Dir[File.join(File.dirname(__FILE__), "../lib", "*.rb")].each {|f| require f}
