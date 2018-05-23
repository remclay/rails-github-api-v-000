ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

require 'capybara/dsl'
require 'capybara/rails'
require 'capybara/rspec'
require 'webmock/rspec'
require 'rack_session_access/capybara'

RSpec.configure do |config|
  config.include Capybara::DSL

  config.before(:each) do
    stub_request(:get, "https://api.github.com/user/repos").
      with(:headers => {'Authorization'=>'token 1'}).
      to_return(:status => 200, :body => [{"name" => "Repo 1", "html_url" => "http://link1.com"}, {"name" => "Repo 2", "html_url" => "http://link2.com"}, {"name" => "Repo 3", "html_url" => "http://link3.com"}].to_json, :headers => {})

    stub_request(:post, "https://github.com/login/oauth/access_token").
      with(:body => {"client_id"=> ENV["GITHUB_CLIENT_ID"], "client_secret"=> ENV["GITHUB_CLIENT_SECRET"], "code"=>"20"},
      :headers => {'Accept'=>'application/json'}).
      to_return(:status => 200, :body => {"access_token"=>"1"}.to_json, :headers => {})

    stub_request(:get, "https://api.github.com/user").
      with(:headers => {'Authorization'=>'token 1'}).
      to_return(:status => 200, :body => {"login"=>"your_username"}.to_json, :headers => {})

    stub_request(:post, "https://api.github.com/user/repos").
      with(:body => {"{\"name\":\"a-new-repo\"}"=>true},
      :headers => {'Authorization'=>'token 1'}).
      to_return(:status => 201, :body => "", :headers => {})
    #
    #
    #
    #   stub_request(:post, "https://github.com/login/oauth/access_token?client_id=440982e5e9ba1389332c&client_secret=6838442f870b325490d57d4a964cc0884d84c8fb&code=20").
    #            with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Length'=>'0', 'User-Agent'=>'Faraday v0.9.1'}).
    #            to_return(:status => 200, :body => "", :headers => {})
    #
    #          # registered request stubs:
    #
    #          stub_request(:post, "https://api.github.com/user/repos").
    #            with(:body => {"{\"name\":\"a-new-repo\"}"=>true},
    #                 :headers => {'Authorization'=>'token 1'})
    #          stub_request(:get, "https://api.github.com/user").
    #            with(:headers => {'Authorization'=>'token 1'})
    #          stub_request(:post, "https://github.com/login/oauth/access_token").
    #            with(:body => {"client_id"=>"440982e5e9ba1389332c", "client_secret"=>"6838442f870b325490d57d4a964cc0884d84c8fb", "code"=>"20"},
    #                 :headers => {'Accept'=>'application/json'})
    #          stub_request(:get, "https://api.github.com/user/repos").
    #            with(:headers => {'Authorization'=>'token 1'})
    #
    #
    #

      #
      #
      # stub_request(:get, "https://github.com/user/repos?access_token=1").
      #          with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.1'}).
      #          to_return(:status => 200, :body => "", :headers => {})
      #
      #        # registered request stubs:
      #
      #        stub_request(:post, "https://api.github.com/user/repos").
      #          with(:body => {"{\"name\":\"a-new-repo\"}"=>true},
      #               :headers => {'Authorization'=>'token 1'})
      #        stub_request(:get, "https://api.github.com/user").
      #          with(:headers => {'Authorization'=>'token 1'})
      #        stub_request(:post, "https://github.com/login/oauth/access_token").
      #          with(:body => {"client_id"=>"440982e5e9ba1389332c", "client_secret"=>"6838442f870b325490d57d4a964cc0884d84c8fb", "code"=>"20"},
      #               :headers => {'Accept'=>'application/json'})
      #        stub_request(:get, "https://api.github.com/user/repos").
      #          with(:headers => {'Authorization'=>'token 1'})
      #
      #
      #
      #
      # stub_request(:post, "https://api.github.com/user/repos").
      #    with(:body => {"{\"name\":\"a-new-repo\"}"=>true},
      #         :headers => {'Authorization'=>'token 1'})
      #  stub_request(:get, "https://api.github.com/user").
      #    with(:headers => {'Authorization'=>'token 1'})
      #  stub_request(:post, "https://github.com/login/oauth/access_token").
      #    with(:body => {"client_id"=>"440982e5e9ba1389332c", "client_secret"=>"6838442f870b325490d57d4a964cc0884d84c8fb", "code"=>"20"},
      #         :headers => {'Accept'=>'application/json'})
      #  stub_request(:get, "https://api.github.com/user/repos").
      #    with(:headers => {'Authorization'=>'token 1'})

  end
end

WebMock.disable_net_connect!(allow_localhost: true)
# WebMock.allow_net_connect!
