_.extend Template.logs_bootstrap,
  log_messages: ->
    TLog._getLogs()

  loglevel_names: (i)->
    "cool" + i
    TLog.LOGLEVEL_NAMES[i]

  lb_loglevel_decoration: ->
    switch @loglevel
      when TLog.LOGLEVEL_FATAL then cl = "label-inverse"
      when TLog.LOGLEVEL_ERROR then cl = "label-important"
      when TLog.LOGLEVEL_WARNING then cl = "label-warning"
      when TLog.LOGLEVEL_INFO then cl = "label-info"
      when TLog.LOGLEVEL_VERBOSE then cl = "label-success"

  equals: (lvalue,rvalue,options)->
    if arguments.length < 3
      throw new Error("Helper equals needs 2 parameters")
    if lvalue!=rvalue
      options.inverse(this)
    else
      options.fn(this)

_.extend Template.logs_simple,
  log_messages: ->
    TLog._getLogs()
