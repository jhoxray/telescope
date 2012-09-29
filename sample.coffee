#instanciating global logger
TL = new TLog(TLog.LOGLEVEL_MAX,true)
TL.verbose("created Tlogger with loglevel " + TL.currentLogLevelName() + " and printing to console set to " + TL._printToConsole)

resetTestMessages = ->
  TL.fatal("Something's really broken!")
  TL.error("There's an error, start debugging")
  TL.warn("Don't you think you should write this in Haskell?")
  TL.info("Boring informational message")
  TL.verbose("Really long and full of insights text about how your app is doing this and that and whatever bells and whistles you still want to add")

Meteor.startup ->
  if Meteor.isServer
    TL.info("Starting up the app on the server")
    resetTestMessages()
  if Meteor.isClient
    TL.info("Starting up the app on the client")
    resetTestMessages()
