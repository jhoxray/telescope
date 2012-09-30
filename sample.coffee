#instanciating global logger
TL = TLog.getLogger()
TL.verbose("created Tlogger with loglevel " + TL.currentLogLevelName() + " and printing to console set to " + TL._printToConsole)

random_messages = [
  "Ah! Trying to trick the system?"
  "Come on! You can do better than that!"
  "boh-ring..."
  "There's only so many random messages, so start typing"
  "This is a log message"
  "Telescope Logger is a cool package"
  ]


#putting some log messages
resetTestMessages = ->
  if TL.logCount() > 500
    TL.clear()
    TL.warn("Cleared logs as they grew to more than 500 records")
  TL.fatal("Something's really broken!")
  TL.error("There's an error, start debugging")
  TL.warn("Don't you think you should write this in Haskell?")
  TL.info("Boring informational message")
  TL.verbose("Really long and full of insights text about how your app is doing this and that and whatever bells and whistles you still want to add")

#starting up Meteor and ensuring some log messages are put into db
Meteor.startup ->
  if Meteor.isServer
    TL.info("Starting up the app on the server")
    resetTestMessages()
  if Meteor.isClient
    TL.info("Starting up the app on the client")
    resetTestMessages()

if Meteor.isServer
  #defining a server function for logging a server-originated log from the client. Confusing, eh?
  Meteor.methods
    log_remote: (msg,level)->
      TL._log(msg,level)


#template that handles Sample App events (button clicks to add log messages)
if Meteor.isClient
  _.extend Template.sample_app,
    events:
      "click .btn": (evt)->
        source = $("#server_or_client").val()
        i = parseInt evt.target.getAttribute("severity")
        msg = $("#log_message").val()

        if !msg
          k = Math.floor((Math.random()*6))
          msg = random_messages[k]

        if source is "client"
          #easy, simply calling log function. BTW, DON'T use _log in your apps, it's a private method :)
          TL._log(msg,i)
        else
          #tricky, need to call an actual method on the server so that the message logs with correct source
          #of course we could simply override the setting, but where's the fun in that?
          Meteor.call("log_remote",msg,i)




        $("#log_message").val ""

