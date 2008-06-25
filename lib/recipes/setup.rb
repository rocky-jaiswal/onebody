namespace :deploy do
  
  namespace :setup_mode do
    
    desc 'Starts a OneBody in setup mode on port 7999 (by default).'
    task :start, :roles => :app do
      run "cd #{current_path} && script/server -d -e setup -p #{fetch(:setup_port, 7999)}"
    end
    
    desc 'Stops setup mode.'
    task :stop, :roles => :app do
      pid = run_and_return("ps aux | grep '[r]uby script/server webrick -d -e setup'").split[1]
      run "kill -HUP #{pid}"
    end
    
    desc 'Retrieves the setup mode authorization secret.'
    task :secret, :roles => :app do
      puts "\nThe setup secret is:"
      puts run_and_return("cat #{current_path}/setup-secret")
    end
    
  end
  
end
