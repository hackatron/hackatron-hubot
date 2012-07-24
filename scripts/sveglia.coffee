# Description:
#   Set a countdown timer
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot sveglia <name> <duration> - Start countdown timer for <duration> seconds
#
# Authors:
#   Giovanni Cappellotto

module.exports = (robot) ->
  robot.respond /(sveglia|timer) ([\w .-_]+) ([0-9]+)/i, (msg) ->
    name    = msg.match[1]
    seconds = msg.match[2]
    delay   = (ms, func) -> setTimeout func, ms
    
    delay seconds*1000, ->
      msg.send "#{msg.message.user.name}: '#{name}' timer end"
    
    if seconds > 10
      (num for num in [10..1]).forEach (second) ->
        delay (seconds-second)*1000, ->
          msg.send "-#{second} at '#{name}' timer end"