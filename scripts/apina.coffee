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
        msg.send "NSFW http://apinaporn.com/" + res.headers.location.match(/\d+/)[0] + ".jpg"
