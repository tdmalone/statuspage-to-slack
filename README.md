Docker Hub build notifications for Slack
========================================

A tiny Sinatra app that receives webhooks from Docker Hub and re-posts them as Slack formatted hooks.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## Setup

1. Generate an incoming webhook in the Slack integration settings e.g. `https://hooks.slack.com/services/<your-service-tag…>`
2. Create a new webhook on Docker Hub with pointing to this url. e.g. `https://<your-heroku-subdomain>.herokuapp.com/services/<your-service-tag…>`
