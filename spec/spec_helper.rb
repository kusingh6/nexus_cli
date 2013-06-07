require 'rubygems'
require 'bundler'
require 'spork'

def setup_rspec
  RSpec.configure do |config|

    config.before(:each) do
      clean_tmp_path
    end
  end
end

Spork.prefork do
  require 'webmock/rspec'

  APP_ROOT = File.expand_path('../../', __FILE__)
  setup_rspec
  ENV["NEXUS_CONFIG"] = File.join(APP_ROOT, "spec", "fixtures", "nexus.config")
end

Spork.each_run do
  require 'nexus_cli'
end

def app_root_path
  Pathname.new(File.expand_path('../..', __FILE__))
end

def fixtures_path
  app_root_path.join('spec/fixtures')
end

def clean_tmp_path
  FileUtils.rm_rf(tmp_path)
  FileUtils.mkdir_p(tmp_path)
end

def fixtures_path
  app_root_path.join('spec/fixtures')
end

def tmp_path
  app_root_path.join('spec/tmp')
end
