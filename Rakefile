require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new do |task|
  task.libs.push "test"
  task.pattern = "test/**/*_test.rb"
  task.warning = false
end

task :default => :test