listen "/tmp/.ps_sock", :backlog => 64
listen 3000, :tcp_nopush => true
timeout 30

pid 'tmp/pids/unicorn.pid'

stderr_path "/var/log/position_strategy/unicorn/stderr.log"
stdout_path "/var/log/position_strategy/unicorn/stdout.log"

worker_processes   !ENV['RACK_ENV'] ? 1
  : ENV['RACK_ENV'] == 'production' ? 2
  :                                   1

preload_app true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
   end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
