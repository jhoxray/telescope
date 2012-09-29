#Twitter Bootstrap formatted template
_.extend Template.logs_bootstrap,
  created: ->
    Session.set("bl_sort_desc", true)
    Session.set("bl_sort_by","timestamp")

  log_messages: ->
    sort_order = if Session.get("bl_sort_desc") then -1 else 1
    sort = {timestamp: sort_order}
    switch Session.get("bl_sort_by")
      when "severity" then sort = {loglevel: sort_order}
      when "source" then sort = {isServer: sort_order}
    TLog._getLogs(sort)

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

  lb_loglevel_row_decoration: ->
    switch @loglevel
      when TLog.LOGLEVEL_FATAL then cl = "error"
      when TLog.LOGLEVEL_ERROR then cl = "error"
      when TLog.LOGLEVEL_WARNING then cl = "warning"

  events:
    "click #lbh_timestamp": ->
      #TLog._getLogger().verbose("clicked on timestamp")
      Session.set("bl_sort_by","timestamp")
      sort_desc = Session.get("bl_sort_desc")
      if sort_desc then Session.set("bl_sort_desc",false) else Session.set("bl_sort_desc",true)

    "click #lbh_severity": ->
      #TLog._getLogger().verbose("clicked on severity")
      Session.set("bl_sort_by","severity")
      sort_desc = Session.get("bl_sort_desc")
      if sort_desc then Session.set("bl_sort_desc",false) else Session.set("bl_sort_desc",true)

    "click #lbh_source": ->
      #TLog._getLogger().verbose("clicked on source")
      Session.set("bl_sort_by","source")
      sort_desc = Session.get("bl_sort_desc")
      if sort_desc then Session.set("bl_sort_desc",false) else Session.set("bl_sort_desc",true)

# very basic template
_.extend Template.logs_simple,
  log_messages: ->
    TLog._getLogs()
