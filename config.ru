require 'bundler/setup'

require 'sinatra/base'
require 'rest-client'
require 'json'

# For documentation on incoming webhooks see
# https://help.statuspage.io/knowledge_base/topics/webhook-notifications
# and scroll down to Incident Updates

class SlackStatuspageApp < Sinatra::Base
  get "/*" do
    params[:splat].first
  end
  post "/*" do
    #statuspage = JSON.parse(request.body.read)
    slack = {text: request.body.read}
    RestClient.post("https://hooks.slack.com/#{params[:splat].first}", payload: slack.to_json)
  end
end

run SlackStatuspageApp
