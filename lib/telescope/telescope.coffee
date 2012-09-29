#do we need this?
root = exports ? this

_global_logs = new Meteor.Collection 'telescope_logs'

#very insecure, yes
_global_logs.allow {
  insert:
    () -> true
  remove: ->
    true
}

#main and static class implementing very basic logging. using class just to provide some encapsulation basically.
class TLog
  #@_instance = undefined

  @LOGLEVEL_FATAL = 0
  @LOGLEVEL_ERROR = 1
  @LOGLEVEL_WARNING = 2
  @LOGLEVEL_INFO = 3
  @LOGLEVEL_VERBOSE = 4
  @LOGLEVEL_MAX = 5

  @LOGLEVEL_NAMES = [
    "FATAL", "ERROR", "WARNING", "INFO", "VERBOSE", "MAX"
  ]

  constructor: (@_currentLogLevel, @_printToConsole)->
    @_logs = _global_logs
    if Meteor.isServer
      Meteor.publish '_telescope_logs',()->
        _global_logs.find {}, {sort: {timestamp: -1}, limit:100}
    if Meteor.isClient
      Meteor.subscribe('_telescope_logs')


  setOptions: (loglevel, want_to_print = true) ->
    if (loglevel>=0) and (loglevel<=3)
      @_currentLogLevel = loglevel
    @_printToConsole = want_to_print

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
      timestamp.getUTCHours()+ ':' + timestamp.getUTCMinutes() + ':' + timestamp.getUTCSeconds() + ':' + timestamp.getUTCMilliseconds()

  _ps: (s)->
    '['+s+']'

  @_getLogs: ->
    _global_logs.find {}, sort: {timestamp: -1}

  clearLogs: ->
    @_logs.remove {}



###

