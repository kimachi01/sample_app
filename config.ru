# This file is used by Rack-based servers to start the application.

#require ::File.expand_path('../config/environment',  __FILE__)

app_dir = File.expand_path('../config/environment',  __FILE__)
require app_dir
run Rails.application

#require ::File.expand_path('../config/environment.rb',  __FILE__)
#run SampleApp::Application
