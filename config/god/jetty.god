RAILS_ROOT = File.expand_path(File.dirname(File.dirname(File.dirname(__FILE__))))
PID_DIR = File.join(RAILS_ROOT, 'tmp/pids')

God.watch do |w|
  pid_file = Dir.glob(File.join(PID_DIR, "*jetty*.pid")).last

  w.dir = RAILS_ROOT
  w.group = "tul_cdm"
  w.name = "jetty"
  w.start = "rake jetty:start"
  w.stop = "rake jetty:stop"
  w.restart = "rake jetty:restart"
  w.start_grace = 90.seconds
  w.restart_grace = 90.seconds
  w.pid_file = "#{pid_file}"
  w.keepalive

  w.behavior(:clean_pid_file)
end

