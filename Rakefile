require 'bundler/setup'

ENV['RACK_ENV'] ||= 'development'

namespace :docker do
  registry = nil
  container_name = 'docker-sinatra-example'
  container_source_path = '/opt/docker-sinatra-example'
  image_name = 'noonat/docker-sinatra-example'
  image_name = "#{registry}:#{image_name}" if registry
  source_path = File.dirname(__FILE__)

  desc 'Build the Docker image'
  task :build do
    sh 'docker', 'build', '-t', image_name, '.'
  end

  desc 'Pull the Docker image from the registry'
  task :pull do
    sh 'docker', 'pull', image_name
  end

  desc 'Push the Docker image up to the registry'
  task :push do
    sh 'docker', 'push', image_name
  end

  desc 'Run the Docker container in the foreground'
  task :run do
    sh('docker', 'run', '--rm', '--interactive', '--tty', '--publish', '80:80',
       '--name', container_name, image_name)
  end

  desc 'Run Bash within the Docker container'
  task :shell do
    sh('docker', 'run', '--rm', '--interactive', '--tty', '--publish', '80:80',
       '--volume', [source_path, container_source_path].join(':'),
       image_name, '/bin/bash')
  end
end

namespace :server do
  desc 'Run the server'
  task :run do
    sh 'rackup', '--env', ENV['RACK_ENV'], '--port', '80', '--server', 'thin'
  end
end

desc 'Install Git hooks'
task :githooks do
  puts 'Installing git pre-commit hooks'
  open('.git/hooks/pre-commit', 'w') do |file|
    file.write "#!/bin/sh\n"
    file.write "rake lint\n"
  end
  chmod 0755, '.git/hooks/pre-commit', verbose: false
end

desc 'Validate source files'
task :lint do
  sh 'rubocop --display-cop-names'
end

desc 'Use Guard to watch for changes and reload things'
task :watch do
  require 'guard'
  exec 'guard', 'start', '--clear'
end
