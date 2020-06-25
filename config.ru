require 'bundler/setup'

require 'sinatra/base'
require 'rest-client'
require 'json'
require 'time'

# For documentation on incoming webhooks see
# https://help.statuspage.io/knowledge_base/topics/webhook-notifications
# and scroll down to Incident Updates

def build_title_block(title, link, timestamp)
  block = <<~END
  {
    "type": "section",
    "text": {
      "type": "mrkdwn",
      "text": "[#{title}](#{link})\\n
               #{timestamp}"
    }
  }
  END
  return block

def build_update_block(update_hash)
  status = update_hash["status"]
  timestamp = update_hash["updated_at"]
  description = update_hash["body"]

  block = <<~END
  {
    "type": "divider"
  },
  {
    "type": "section",
    "text": {
      "type": "mrkdwn",
      "text": "**#{status}**\\n
               #{timestamp}\\n
               #{description}"
    }
  }
  END

def format_time(timestamp)
  return Time.parse(timestamp).strftime("%b %-d %H:%M %Z")

class SlackStatuspageApp < Sinatra::Base
  get "/*" do
    params[:splat].first
  end
  post "/*" do
    block_array = []
    statuspage = JSON.parse(request.body.read)
    
    incident = statuspage["incident"]
    title = incident["name"]
    titleurl = incident["shortlink"]
    timestamp = format_time(incident["started_at"])

    block_array.push(build_title_block(title, titleurl, timestamp))

    updates = statuspage["incident_updates"]
    updates.each { |update_hash|
      block_array.push(build_update_block(update_hash))
    }

    slack = {"blocks": block_array}
    RestClient.post("https://hooks.slack.com/#{params[:splat].first}", payload: slack.to_json)
  end
end

run SlackStatuspageApp
