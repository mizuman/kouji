# Version 1.0

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Hoge::Application.initialize!

Time::DATE_FORMATS[:simple] = "%Y-%m-%d %H:%M"
