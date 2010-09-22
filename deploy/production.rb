
# TODO: write your environment
web = ["127.0.0.1", "127.0.0.1"]

role :web, *web
role :app, *web
role :db, web[0], :primary => true

### if use rvm
#rvmhome = "/u/app"
#rubyver = "1.9.2-p0"
#set :default_environment, {
#  'PATH' => "#{rvmhome}/.rvm/gems/ruby-#{rubyver}/bin:#{rvmhome}/.rvm/gems/ruby-#{rubyver}@global/bin:#{rvmhome}/.rvm/rubies/ruby-#{rubyver}/bin:#{rvmhome}/.rvm/bin:$PATH",
#  'GEM_HOME' => "#{rvmhome}/.rvm/gems/ruby-#{rubyver}',
#  'GEM_PATH' => "#{rvmhome}/.rvm/gems/ruby-#{rubyver}:#{rvmhome}/.rvm/gems/ruby-#{rubyver}@global',
#}

# TODO: append configuration
