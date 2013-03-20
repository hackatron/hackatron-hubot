# Description:
#   Receive an apina
#
# Commands:
#   hubot apina - Receive an apina

module.exports = (robot) ->
  reasons = ->
    robot.brain.data.apina ?= { reasons: [] }
    robot.brain.data.apina.reasons

  robot.respond /(.+) is (not )?a reason for apina/i, (msg) ->
    reasons = reasons()

    if msg.match[2]
      for i in [0..(reasons.length - 1)]
        if reasons[i] == msg.match[1]
          reasons.splice(i, 1)
          msg.send("Ok, #{msg.match[1]} is not a reason for apina anymore.")
          return
    else
      for reason in reasons
        if reason == msg.match[1]
          msg.send("#{msg.match[1]} is already a reason for apina.")
          return

      msg.send("Ok, #{msg.match[1]} is now a reason for apina.")
      reasons.push(msg.match[1])

  robot.respond /apina( with a reason)?/i, (msg) ->
    if msg.match[1]
      if reasons = reasons()
        reason = msg.random(reasons)
      else
        msg.send("There are no reasons for apina right now.")
        return

    msg.http("http://apinaporn.com/random")
      .headers(Cookie: 'i_need_it_now=fapfap')
      .get() (err, res, body) ->
        message = "http://apinaporn.com/" + res.headers.location.match(/\d+/)[0] + ".jpg"
        message = [message, reason].join(' for ') if reason?
        msg.send(message)