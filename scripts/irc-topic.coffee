# Description:
#   IRC Channel topic JSONP API
#
# Endpoints:
#   /hubot/topic/:channel - Channel topic

module.exports = (robot) ->
  
  robot.router.get "/hubot/topic/:channel", (req, res) ->
    robot.brain.data.topics ?= {}

    topic = robot.brain.data.topics['#' + req.params.channel]
    url = require('url').parse(req.url, true);

    res.writeHead(200, {'Content-Type': 'application/json'})
    res.end url.query.callback + '(' + JSON.stringify(topic) + ')';

  robot.adapter.bot.addListener 'topic', (channel, topic) ->
    robot.brain.data.topics ?= {}

    robot.brain.data.topics[channel] = topic