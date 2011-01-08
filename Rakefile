#require File.expand_path('../../config/application', __FILE__)

require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/packagetask'
require 'rake/gempackagetask'

gemfile = File.expand_path('../spec/test_app/Gemfile', __FILE__)
if File.exists?(gemfile)
  require 'bundler'
  ENV['BUNDLE_GEMFILE'] = gemfile
  Bundler.setup

  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new

  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new do |t|
    t.cucumber_opts = %w{--format pretty}
  end
end


spec = eval(File.read('spree_wishlist.gemspec'))

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
end

desc "Release to gemcutter"
task :release => :package do
  require 'rake/gemcutter'
  Rake::Gemcutter::Tasks.new(spec).define
  Rake::Task['gem:push'].invoke
end

desc "Default Task"
task :default => [ :spec ]

# TODO: pull in the spree/core/Rakefile bits that set up for testing
desc "Regenerates a Rails 3 app for testing"
task :test_app do
# TODO - this path requires a certain directory structure -- need
# to think about how to refactor
  require '../spree/lib/generators/spree/test_app_generator'
  class WishlistTestAppGenerator < Spree::Generators::TestAppGenerator
    def tweak_gemfile
      append_file "Gemfile" ,
        <<-gems

gem 'fabrication'
gem 'spree_core', '>=0.30.0'
gem 'spree_auth', '>=0.30.0'
gem 'spree_wishlist', :path => "#{File.dirname(__FILE__)}"

        gems
    end

    def install_spree_gems
      inside "test_app" do
        run 'rake spree_core:install'
        run 'rake spree_auth:install'
        run 'rake spree_wishlist:install'
      end
    end

#    def install_spree_auth
#      inside "test_app" do
#        run 'rake spree_auth:install'
#      end
#    end

    def migrate_db
      run_migrations
    end
  end
  WishlistTestAppGenerator.start
end

namespace :test_app do
  desc 'Rebuild test and cucumber databases'
  task :rebuild_dbs do
    system("cd spec/test_app && rake db:drop db:migrate RAILS_ENV=test && rake db:drop db:migrate RAILS_ENV=cucumber")
  end
end

