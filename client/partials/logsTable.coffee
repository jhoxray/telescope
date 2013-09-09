Template.logsTable.helpers
  prettyJSON: (json)->
    syntaxHighlight json if json?

  localLogs:->
    Observatory.getMeteorLogger()._logsCollection.find {type: {$ne: 'monitor'}}, {sort: {timestamp: -1}}
    
  theme: ->
    Session.get("bl_current_theme")

  loglevel_names: (i)->
    i = i ? @loglevel
    TLog.LOGLEVEL_NAMES_SHORT[i]

  textMessage: ->
    @textMessage ? @message #backward compatibility

#timestamp formatting helper for the display
  format_timestamp: (ts)->
    #console.log "Formatting date: " + ts
    #ts
    d = new Date(ts)
    Observatory.viewFormatters._convertDate(d) + ' ' + Observatory.viewFormatters._convertTime(d)

  getUser: ->
    user = @userId or @uid or @user #backward compatibility
    user = "" if not user?
    user


#applying class to labels showing loglevel / severity
  lb_loglevel_decoration: ->
    severity = @severity ? @loglevel
    switch severity
      when TLog.LOGLEVEL_FATAL then cl = "label-fatal"
      when TLog.LOGLEVEL_ERROR then cl = "label-danger"
      when TLog.LOGLEVEL_WARNING then cl = "label-warning"
      when TLog.LOGLEVEL_INFO then cl = "label-info"
      when TLog.LOGLEVEL_VERBOSE then cl = "label-success"
      when TLog.LOGLEVEL_DEBUG then cl = "label-default"

#apllying class to the message text (<td>) based on loglevel
  lb_loglevel_msg_decoration: ->
    severity = @severity ? @loglevel
    switch severity
      when TLog.LOGLEVEL_FATAL then cl = "lb_msg_error"
      when TLog.LOGLEVEL_ERROR then cl = "text-error"#"lb_msg_error"
      when TLog.LOGLEVEL_WARNING then cl = "lb_msg_warning"

#apllying class to the whole log row based on loglevel
  lb_loglevel_row_decoration: ->
    # Turning OFF for now as this is needed for the "light" scheme
    severity = @severity ? @loglevel
    switch severity
      when TLog.LOGLEVEL_FATAL then cl = "fatal-error"
      when TLog.LOGLEVEL_ERROR then cl = "danger"
      when TLog.LOGLEVEL_WARNING then cl = "warning"
      #when TLog.LOGLEVEL_INFO then cl = "info"

