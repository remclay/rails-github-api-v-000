class RepositoriesController < ApplicationController

  def index
    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    # resp = Faraday.get("https://github.com/user/repos") do |req|
    #   req.params['access_token'] = session[:token]
    #   # req.params['Authorization'] = session[:token]
    # end
    @repos = JSON.parse(response.body)
  end

  def create
    resp = Faraday.post("https://github.com/user/repos") do |req|
      req.params["name"] = params["name"].to_json
      req.params['access_token'] = session[:token]
    end
    redirect_to '/'
  end
end
