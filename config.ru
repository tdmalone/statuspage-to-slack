require 'bundler/setup'

require 'sinatra/base'
require 'rest-client'
require 'json'


require './block_utils'

# For documentation on incoming webhooks see
# https://help.statuspage.io/knowledge_base/topics/webhook-notifications
# and scroll down to Incident Updates

class SlackStatuspageApp < Sinatra::Base
  get "/*" do
    params[:splat].first
  end
  post "/*" do
    statuspage = JSON.parse(request.body.read)
    if(!statuspage.has_key?("incident_updates")){

      incident = statuspage["incident"]
      title = incident["name"]
      titleurl = incident["shortlink"]
      timestamp = format_time(incident["started_at"])
      
      block_array = []
      block_array.push(build_title_block(title, titleurl, timestamp))
      
      updates = incident["incident_updates"]
      
      block_array.push(build_divider_block())
      block_array.push(build_update_block(updates.first))
      
      slack = {text: "Status Page Update", blocks: block_array}
      RestClient.post("https://hooks.slack.com/#{params[:splat].first}", payload: slack.to_json)
    }

  end
end

run SlackStatuspageApp
