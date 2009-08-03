RAILS_GEM_VERSION = '2.3.3' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem 'authlogic'
  config.gem 'hardbap-feedzirra', :lib => 'feedzirra', 
                                  :source => 'http://gems.github.com',
                                  :version => '~> 0.0.16'

  config.gem 'mislav-will_paginate', :lib => 'will_paginate',
                                     :source => 'http://gems.github.com',
                                     :version => '~> 2.3.11'
  
  config.time_zone = 'UTC'
end
