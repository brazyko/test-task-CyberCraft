require 'net/http'
require 'json'
require 'uri'

class TaskController < ApplicationController
  def index
  end

  def about
    @val = params['forminpt']['comments']
    @token = ENV["API_GIT_KEY"]
    @str = "query { user( login: "+'"'+@val+'"'+") { name repositories(first: 100) {nodes {name} } } }"
    @uri = URI("https://api.github.com/graphql")
    @res = Net::HTTP.start(@uri.host, @uri.port, use_ssl: true) do |http|
      @req = Net::HTTP::Post.new(@uri)
      @req['Content-Type'] = 'application/json'
      @req['Authorization'] = "bearer #{@token}"
      @req.body = JSON[{'query' => @str}]
      http.request(@req)
    end
    @response = JSON.parse(@res.body)
    @name = @response['data']['user']['name']
    @repos = []
    for el in @response['data']['user']['repositories']['nodes'] do
      @repos.push(el['name'])
    end
  end
end

