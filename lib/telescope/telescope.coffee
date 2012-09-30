# Class that hanles all the logging logic 
#
# @example Getting a logger that will print only WARNING and more severe messages both to db and console:
#     TL = TLog.getLogger(TLog.LOGLEVEL_WARNING, true)
#
class TLog
  @_instance = undefined

  @_global_logs = new Meteor.Collection 'telescope_logs'

  #very insecure, yes. For now this is the only dependency on auth branch so "?" let's us take care of this silently.
  # TODO: make this configurable 
  @_global_logs.allow? {
    insert:
      () -> true
    update: ->
      false
    remove: ->
      true
  }

  # Get a logger with options
  #
  # @param [TLog enum] loglevel desired loglevel, one of TLog.LOGLEVEL_FATAL,TLog.LOGLEVEL_ERROR,TLog.LOGLEVEL_WARNING,TLog.LOGLEVEL_INFO,TLog.LOGLEVEL_VERBOSE
  # @param [Bool] want_to_print if true, log messages will be printed to the console as well
  #
  @getLogger: (loglevel = TLog.LOGLEVEL_MAX, want_to_print = true)->
    @_instance?=new TLog(loglevel,want_to_print, false)

  @LOGLEVEL_FATAL = 0
  @LOGLEVEL_ERROR = 1
  @LOGLEVEL_WARNING = 2
  @LOGLEVEL_INFO = 3
  @LOGLEVEL_VERBOSE = 4
  @LOGLEVEL_MAX = 5

  @LOGLEVEL_NAMES = [
    "FATAL", "ERROR", "WARNING", "INFO", "VERBOSE", "MAX"
  ]

  constructor: (@_currentLogLevel, @_printToConsole, show_warning = true)->
    @_logs = TLog._global_logs
    if Meteor.isServer
      Meteor.publish '_telescope_logs',()->
        TLog._global_logs.find {}, {sort: {timestamp: -1}, limit:100}
    if Meteor.isClient
      Meteor.subscribe('_telescope_logs')
    @warn("You should use TLog.getLogger(loglevel, want_to_print) method instead of a constructor! Constructor calls may be removed 
      in the next versions of the package.") if show_warning


  # Set options for a logger
  #
  # @param [TLog enum] loglevel desired (see getLogger())
  # @param [Bool] whether to print to the console
  #
  setOptions: (loglevel, want_to_print = true) ->
    if (loglevel>=0) and (loglevel<=3)
      @_currentLogLevel = loglevel
    @_printToConsole = want_to_print

  # Main logging methods:
  fatal: (msg)->
    @_log(msg,TLog.LOGLEVEL_FATAL)

  error: (msg)->
    @_log(msg,TLog.LOGLEVEL_ERROR)

  warn: (msg)->
    @_log(msg,TLog.LOGLEVEL_WARNING)

  info: (msg)->
    @_log(msg,TLog.LOGLEVEL_INFO)

  verbose: (msg)->
    @_log(msg,TLog.LOGLEVEL_VERBOSE)

  currentLogLevelName: ->
    TLog.LOGLEVEL_NAMES[@_currentLogLevel]

  logCount: ->
    @_logs.find({}).count()

  #internal method doing the logging
  _log: (msg, loglevel = 3) ->

    if loglevel <= @_currentLogLevel
      srv = false
      if Meteor.is_server 
        srv = true
      timestamp = new Date()
      ts = @_convertTimestamp(timestamp)
      full_message = if srv then @_ps(ts) + "[SERVER]" else @_ps(ts) + "[CLIENT]"
      full_message+= @_ps(TLog.LOGLEVEL_NAMES[loglevel]) #TODO: RANGE CHECK!!!
      full_message+= ' ' + msg
      @_logs.insert
        isServer: srv
        message: msg
        loglevel: loglevel
        timestamp_text: ts
        timestamp: timestamp.getTime()
        full_message: full_message

      console.log(full_message) if @_printToConsole

  _convertTimestamp: (timestamp)->
    st = timestamp.getUTCDate() + '/' + timestamp.getUTCMonth() + '/'+timestamp.getUTCFullYear() + ' ' +
      timestamp.getUTCHours()+ ':' + timestamp.getUTCMinutes() + ':' + timestamp.getUTCSeconds() + '.' + timestamp.getUTCMilliseconds()

  _ps: (s)->
    '['+s+']'

  @_getLogs: (sort)->
    if sort
      @_global_logs.find({}, sort: sort)
    else
      @_global_logs.find {}, sort: {timestamp: -1}

  #Ouch! This should be really protected once auth is figured out.
  clear: ->
    @_logs.remove {}



