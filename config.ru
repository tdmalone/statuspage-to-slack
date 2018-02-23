require 'bundler/setup'

require 'sinatra/base'
require 'rest-client'
require 'json'
require 'uri'

class SlackStatuspageApp < Sinatra::Base

  # For GET requests, just echo everything back to the browser to confirm we're online.
  get "/*" do
    params[:splat].first
  end

  # Handle incoming POST requests!
  post "/*" do

    # For documentation on incoming webhooks see
    # https://help.statuspage.io/knowledge_base/topics/webhook-notifications
    # and scroll down to Incident Updates.

    raw = request.body.read
    statuspage = JSON.parse( raw )

    # For further development purposes, let's log the incoming data.
    puts raw

    # We'll ignore component updates for now - we're only interested in incidents.
    # Component updates are more for automation than notifications (see above link).
    if ( ! statuspage['incident'] ) then
      puts "Dropping payload as no 'incident' is defined."
      return
    end

    # Map potential incident impact values to Slack attachment colour values.
    # @see https://api.slack.com/docs/message-attachments#color
    colorMappings = {
      'minor'     => 'warning',
      'major'     => 'danger',
      'criticial' => '#000'
    }

    # Put Slack message together.
    slack = {

      username: URI.parse( statuspage['meta']['unsubscribe'] ).host,

      attachments: [{
        title:      statuspage['incident']['name'],
        title_link: statuspage['incident']['shortlink'],
        text:       statuspage['incident']['incident_updates'][0]['body'],
        color:      colorMappings[ statuspage['incident']['impact'] ]
      }]

    }

    # Send to Slack.
    RestClient.post( "https://hooks.slack.com/#{params[:splat].first}", payload: slack.to_json )

  end # Post do.
end # Class SlackStatuspageApp.

run SlackStatuspageApp
