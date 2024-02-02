require "bundler/gem_tasks"
task :default => :spec


task :upload do |t|
  sh "gem build wxapi.gemspec"
  sh "gem push wxapi-#{WxApi::VERSION}.gem"
end
