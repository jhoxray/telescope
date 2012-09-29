#instanciating global logger
TL = new TLog(TLog.LOGLEVEL_MAX,true)
console.log("created Tlogger with " + TL._currentLogLevel + " and " + TL._printToConsole)

TL.info("test log")

Meteor.startup ->
  if Meteor.isServer
    TL.info("Starting up the app on the server")
  if Meteor.isClient
    TL.info("Starting up the app on the client")
