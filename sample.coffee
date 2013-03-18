#instanciating global logger
TL = TLog.getLogger(TLog.LOGLEVEL_MAX, true, true)
TL.verbose("created Tlogger with loglevel " + TL.currentLogLevelName() + " and printing to console set to " + TL._printToConsole)

TLog.allowRemove -> false


if Meteor.isClient
  Meteor.pages
    '/':
      to: "main"
      as: "main"
      nav: "main"

    '/logging':
      to: "logging_template"
      as: "logging_template"
      nav: 'logging'

    '/tests':
      to: 'tests'
      as: 'tests'
      nav: 'tests'

    "*":
      to: "notFound"
    #before: setLayout

  Handlebars.registerHelper "navClassFor", (nav, options) ->
    if Meteor.router.navEquals(nav) then "active" else ""



  Session.set "bl_default_panel", "half"

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
  
  if TL.logCount() > 300
    TLog._clear()
    TL.warn("Cleared logs as they grew to more than 300 records")
  TL.fatal("Something's really broken!")
  TL.error("There's an error, start debugging")
  TL.warn("Don't you think you should write this in Haskell?","templates")
  TL.verbose("Really long and full of insights text about 
    how your app is doing this and that and whatever bells and whistles you still want to add.
    Also showing multiline and other related functionality. \nLog messages are printed in <pre> tags so you are free 
    to enter really long and text-formatted messages here - such as code fragments
    \n\tfn = function() {\n\t\treturn true;\n\t};")
  TL.info("Observatory supports different log levels / severity")
  TL.info("Also, you may want to add an optional module name to easier sort the logs. Like here.","my module")
  

inspectObject = (obj)->
  
  TL.warn("Inspecting object " + obj.name)
  for propName of obj
    TL.info(propName + ": " + obj[propName])
  TL.warn("Finished inspecting object ")

dump_state1 = ->
  for key of Session.key_deps
    console.log(key + ": " + Session.get(key))


#starting up Meteor and ensuring some log messages are put into db
Meteor.startup ->
  if Meteor.isServer
    #TL.clear()
    TL.info("Starting up the app on the server")
    resetTestMessages()
    #inspectObject(Meteor)
    #Session.dump_state()
    
    
  if Meteor.isClient
    TL.info("Starting up the app on the client")
    resetTestMessages()
    #Session.dump_state()
    #inspectObject(Meteor) 
    #inspectObject(Session.keys)
    #TL.info("Just the object: " + Object.getOwnPropertyNames(Session.keys))
    
    #dump_state1()

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

