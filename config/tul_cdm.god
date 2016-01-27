RAILS_ROOT = File.dirname(File.dirname(__FILE__))
PID_DIR = File.join(RAILS_ROOT, 'tmp/pids')

God.watch do |w|
  pid_file = File.join(PID_DIR, '_vagrant_jetty_development.pid')

  w.dir = RAILS_ROOT
  w.name = "jetty"
  w.start = "cd #{RAILS_ROOT}; rake jetty:start"
  w.stop = "cd #{RAILS_ROOT}; rake jetty:stop"
  w.restart = "cd #{RAILS_ROOT}; rake jetty:restart"
  w.start_grace = 90.seconds
  w.restart_grace = 90.seconds
  w.pid_file = "#{pid_file}"
  w.keepalive

  w.behavior(:clean_pid_file)
end

God.watch do |w|
  pid_file = File.join(PID_DIR, 'server.pid')

  w.dir = RAILS_ROOT
  w.name = "hydra"
  w.start = "(cd #{RAILS_ROOT}; rails server -d -P #{pid_file})"
  w.stop = "kill $(cat #{pid_file})"
  w.start_grace = 30.seconds
  w.pid_file = "#{pid_file}"
  w.keepalive

  w.behavior(:clean_pid_file)
end
