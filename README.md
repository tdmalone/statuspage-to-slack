statuspage.io webhook notifications for Slack
=============================================

A tiny Sinatra app that receives webhooks from statuspage.io subscriptions and re-posts them as Slack formatted hooks.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## Setup

1. Generate an incoming webhook in the Slack integration settings e.g. `https://hooks.slack.com/services/<your-service-tag…>`
2. Create a new webhook on any statuspage.io status page pointing to this url. e.g. `https://<your-heroku-subdomain>.herokuapp.com/services/<your-service-tag…>`

Based on [docker-to-slack](https://github.com/tdmalone/docker-to-slack), which itself is a fork of a fork.

**NOTE:** This tool is currently under construction. It should work, but it'll send through much more info that it needs to. That will be sorted soon!
