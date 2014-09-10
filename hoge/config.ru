# This file is used by Rack-based servers to start the application.
#require ::File.expand_path('../config/environment',  __FILE__)

#if ENV['RAILS_RELATIVE_URL_ROOT']
#  map ENV['RAILS_RELATIVE_URL_ROOT'] do
#    run Hoge::Application
#  end
#else
#	run Hoge::Application
#end


require ::File.expand_path('../config/environment',  __FILE__)
run Hoge::Application
