#### Init

def select_gem(gemname, version = nil, options = {}) 
  @selects ||= {}
  if yes?("Add #{gemname}? >")
    gem gemname, version, options
    @selects[gemname] = true
  end
end


#### Gems

puts
select_gem 'unicorn'
select_gem 'thin'
select_gem 'devise', '>=1.1.2'

gem 'mysql2'

gem 'will_paginate', '>=3.0.pre2'
gem 'configatron'

#gem "haml-rails", ">= 0.2"
#gem 'inherited_resources', '>=1.1.2'
#gem "formtastic", '>=1.1.0'
#gem 'friendly_id', '~>3.0'
#gem "compass", ">= 0.10.5"

gem 'capistrano', :group => :development
gem 'capistrano-ext', :group => :development

gem "metric_fu", ">=1.5.1", :group => :development

gem 'rspec', '>=2.0.0.beta.20', :group => :test
gem 'rspec-rails', '>=2.0.0.beta.20', :group => [:development, :test]
gem 'webrat', :group => [:development, :test]
#gem 'remarkable', '>=4.0.0.alpha4', :group => :test
#gem 'remarkable_activemodel', '>=4.0.0.alpha4', :group => :test
#gem 'remarkable_activerecord', '>=4.0.0.alpha4', :group => :test
#gem "factory_girl_rails"

gem 'cucumber', ">=0.6.3", :group => :cucumber
gem 'cucumber-rails', ">=0.3.2", :group => :cucumber
#gem 'capybara', ">=0.3.6", :group => :cucumber
#gem 'database_cleaner', ">=0.5.0", :group => :cucumber
#gem 'spork', ">=0.8.4", :group => :cucumber
#gem "pickle", ">=0.4.2", :group => :cucumber

#gem "newrelic_rpm", ">=2.12.3", :group => :production
#gem "hoptoad_notifier", '>=2.3.6'
#gem 'inploy', '>=1.6.8'

#gem 'rails3-generators', :git => "git://github.com/indirect/rails3-generators.git"

run 'bundle install'

plugin 'ouscaffold', :git => 'git://github.com/one-up/ouscaffold.git'
plugin 'configatron-rails', :git => 'git://github.com/one-up/configatron-rails.git'
#plugin 'asset_packager', :git => 'git://github.com/sbecker/asset_packager.git'


#### Deletion

run 'rm public/javascripts/*.js'
remove_file 'public/index.html'
remove_file 'public/images/rails.png'
remove_file 'public/favicon.ico'
remove_file 'README'
remove_file '.gitignore'


#### Generation

application <<-CONFIG
config.generators do |g|
  g.test_framework :rspec, :fixture => true, :views => false
  g.integration_tool :rspec, :fixture => true, :views => true
end
CONFIG

create_file 'README'

generate 'rspec:install'
generate 'devise:install' if @selects['devise']

generate 'configatron_rails:install'

generate 'ouscaffold:layout'
generate 'ouscaffold:i18n'

get "http://github.com/rails/jquery-ujs/raw/master/src/rails.js", "public/javascripts/rails.js"
get "http://code.jquery.com/jquery-1.4.2.min.js", "public/javascripts/jquery.js"
gsub_file "config/application.rb", /(#\s*)(?=config\.action_view\.javascript_expansions\[:defaults\])/, ''

get "http://github.com/one-up/rails3_template/raw/master/dot.gitignore" ,".gitignore"
#get "http://github.com/one-up/rails3_template/raw/master/screen.scss", "app/stylesheets/screen.scss"
#get "http://github.com/one-up/rails3_template/raw/master/application.html.haml", "app/views/layouts/application.html.haml"
#get "http://github.com/one-up/rails3_template/raw/master/factory_girl.rb", "features/support/factory_girl.rb"
#get "http://github.com/one-up/rails3_template/raw/master/devise_steps.rb", "features/step_definitions/devise_steps.rb"
#get "http://github.com/one-up/rails3_template/raw/master/remarkable.rb", "spec/support/remarkable.rb"
#get "http://github.com/one-up/rails3_template/raw/master/build.rake", "lib/tasks/build.rake"
#get "http://github.com/one-up/rails3_template/raw/master/build.sh", "build.sh"
#get "http://github.com/one-up/rails3_template/raw/master/overlay.png", "public/images/overlay.png"
#get "http://github.com/one-up/rails3_template/raw/master/newrelic.yml", "config/newrelic.yml"
#get "http://github.com/one-up/rails3_template/raw/master/hoptoad.rb", "config/initializers/hoptoad.rb"
#get "http://github.com/one-up/rails3_template/raw/master/dot.htaccess", "public/.htaccess"
#get "http://github.com/one-up/rails3_template/raw/master/asset_packages.yml", "config/asset_packages.yml"

run 'capify .'
remove_file 'config/deploy.rb'
get "http://github.com/one-up/rails3_template/raw/master/deploy.rb", "config/deploy.rb"
get "http://github.com/one-up/rails3_template/raw/master/deploy/production.rb", "config/deploy/production.rb"
get "http://github.com/one-up/rails3_template/raw/master/deploy/staging.rb", "config/deploy/staging.rb"

#append_file 'Rakefile', <<-METRIC_FU
#
#MetricFu::Configuration.run do |config|
#  config.rcov[:rcov_opts] << "-Ispec"
#end rescue nil
#METRIC_FU


#### Git

if yes?('Git init, add and commit? >') 
  git :init
  git :add => '.'
  git :commit => "-a -m 'Initial commit'"
end


