# Description:
#   Receive a codinglove link
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot codinglove - Receive a codinglove field
#
# Authors:
#   m3nTe

module.exports = (robot) ->
  robot.respond /codinglove/i, (msg) ->
    msg.http('http://thecodinglove.com/random')
      .get() (err, res, body) ->
        msg.send res.headers.location
