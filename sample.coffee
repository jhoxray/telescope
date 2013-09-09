@TL = TLog.getLogger()

#putting some log messages
resetTestMessages = ->
  ###
  if TL.logCount() > 3000
    TLog._clear()
    TL.warn("Cleared logs as they grew to more than 3000 records")
  ###

  TL.fatal("Something's really broken!")
  TL.error("There's an error, start debugging")
  TL.warn("Don't you think you should write this in Haskell?","templates")
  TL.verbose  """Log messages are printed in `pre` tags so you are free 
                 to enter really long and text-formatted messages here - such as code fragments:
                 <pre class='prettyjson'>fn = function() {
                    return true;
                 }</pre>
              """
  TL.warn("Automagical logging - log http, DDP and other key Meteor internals without writing a single line of code!")
  TL.info("Observatory supports different log levels / severity")
  TL.info("Also, you may want to add an optional module name to easier sort the logs. Like here.","my module")
  


#starting up Meteor and ensuring some log messages are put into db
Meteor.startup ->
  if Meteor.isServer
    Observatory.emitters.Monitor.startMonitor()
    Observatory.meteorServer.publish -> true
    Meteor.methods
      log_remote: (msg,level)->
        TL._emitWithSeverity(level, msg, null, 'user')

    TL.info("Starting up the app on the server")
    resetTestMessages()
    
    
  if Meteor.isClient
    TL.info("Starting up the app on the client")
    resetTestMessages()
    


