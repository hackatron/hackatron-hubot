# Description:
#   Allows Hubot to give you software alternatives using alternativeto.net API
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot alternative to <software> - Gives you alternatives to <software>
#
# Authors:
#   Giovanni Cappellotto

module.exports = (robot) ->
  robot.respond /alternative to (.*)/i, (msg) ->
    software = escape(msg.match[1])
    msg.http("http://api.alternativeto.net/software/#{software}/?count=15")
      .get() (err, res, body) ->
        try
          JSON.parse(body).Items.forEach (item) ->
            msg.send "#{item.Name} (license: #{item.License}) #{item.Url}"
        catch error
          msg.send "Software not found. It will be mine. Oh yes. It will be mine. *sinister laugh*"