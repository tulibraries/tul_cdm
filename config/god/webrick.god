RAILS_ROOT = File.expand_path(File.dirname(File.dirname(File.dirname(__FILE__))))
PID_DIR = File.join(RAILS_ROOT, 'tmp/pids')

God.watch do |w|
  pid_file = File.join(PID_DIR, 'server.pid')

  w.dir = RAILS_ROOT
  w.group = "tul_cdm"
  w.name = "hydra"
  w.start = "rails server -d -P #{pid_file}"
  w.stop = "kill $(cat #{pid_file})"
  w.start_grace = 30.seconds
  w.pid_file = "#{pid_file}"
  w.keepalive

  w.behavior(:clean_pid_file)
end
