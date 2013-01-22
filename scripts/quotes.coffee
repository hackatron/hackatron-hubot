# Description:
#   Assign quotes to people you're chatting with
#
# Commands:
#   hubot <user> said I am a badass guitarist - assign a quote to a user
#   hubot <user> is not a badass guitarist - remove a quote from a user
#   hubot who is <user> - see a user said
#
# Examples:
#   hubot nemesys said scala is the way
#   hubot nemesys said not scala is the way

module.exports = (robot) ->

  getAmbiguousUserText = (users) ->
    "Be more specific, I know #{users.length} people named like that: #{(user.name for user in users).join(", ")}"

  robot.respond /quotes from @?([\w .\-]+)\?*$/i, (msg) ->
    joiner = ', '
    name = msg.match[1].trim()

    if name is "you"
      msg.send "I am the best robot ever"
    else if name is robot.name
      msg.send "I am the best robot ever"
    else
      users = robot.usersForFuzzyName(name)
      if users.length is 1
        user = users[0]
        user.quotes = user.quotes or [ ]
        if user.quotes.length > 0
          if user.quotes.join('').search(',') > -1
            joiner = '; '
          msg.send "#{name} said #{user.quotes.join(joiner)}."
        else
          msg.send "#{name} didn't say anything."
      else if users.length > 1
        msg.send getAmbiguousUserText users
      else
        msg.send "#{name}? Never heard of 'em"

  robot.respond /@?([\w .\-_]+) said (["'\w: \-_]+)[.!]*$/i, (msg) ->
    name    = msg.match[1].trim()
    newQuote = msg.match[2].trim()

    unless name in ['', 'who', 'what', 'where', 'when', 'why']
      unless newQuote.match(/^not\s+/i)
        users = robot.usersForFuzzyName(name)
        if users.length is 1
          user = users[0]
          user.quotes = user.quotes or [ ]

          if newQuote in user.quotes
            msg.send "I know"
          else
            user.quotes.push(newQuote)
            if name.toLowerCase() is robot.name
              msg.send "Ok, I said #{newQuote}."
            else
              msg.send "Ok, #{name} said #{newQuote}."
        else if users.length > 1
          msg.send getAmbiguousUserText users
        else
          msg.send "#{name} didn't say anthing."

  robot.respond /@?([\w .\-_]+) is not (["'\w: \-_]+)[.!]*$/i, (msg) ->
    name    = msg.match[1].trim()
    newQuote = msg.match[2].trim()

    unless name in ['', 'who', 'what', 'where', 'when', 'why']
      users = robot.usersForFuzzyName(name)
      if users.length is 1
        user = users[0]
        user.quotes = user.quotes or [ ]

        if newQuote not in user.quotes
          msg.send "I know."
        else
          user.quotes = (quote for quote in user.quotes when quote isnt newQuote)
          msg.send "Ok, #{name} said no longer #{newQuote}."
      else if users.length > 1
        msg.send getAmbiguousUserText users
      else
        msg.send "#{name} didn't say anthing."
