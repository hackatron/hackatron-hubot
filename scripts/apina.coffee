# Description:
#   Receive an apina
#
# Commands:
#   hubot apina - Receive an apina

module.exports = (robot) ->

  robot.respond /apina/i, (msg) ->
    msg.http("http://apinaporn.com/random")
      .headers(Cookie: 'i_need_it_now=fapfap')
      .get() (err, res, body) ->
        msg.send "http://apinaporn.com/" + res.headers.location.match(/\d+/)[0] + ".jpg [NSFW]"

  robot.respond /apina bomb( (\d+))?/i, (msg) ->
    count = msg.match[2] || 5
    for i in [1...count] by 1
      msg.http("http://apinaporn.com/random")
      .headers(Cookie: 'i_need_it_now=fapfap')
      .get() (err, res, body) ->
        msg.send "http://apinaporn.com/" + res.headers.location.match(/\d+/)[0] + ".jpg [NSFW]"