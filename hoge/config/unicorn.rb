# config/unicorn.rb
#
# see below...
# http://unicorn.bogomips.org/Unicorn/Configurator.html
# http://unicorn.bogomips.org/examples/unicorn.conf.rb
# http://unicorn.bogomips.org/examples/unicorn.conf.minimal.rb

worker_processes 1
preload_app	true
listen		"127.0.0.1:3030"
timeout		30
pid		File.expand_path("tmp/pids/unicorn.pid", ENV["RAILS_ROOT"])
stderr_path	File.expand_path("log/unicorn.log", ENV["RAILS_ROOT"])
stdout_path	File.expand_path("log/unicorn.log", ENV["RAILS_ROOT"])

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
