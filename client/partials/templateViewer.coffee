Template.templateViewer.created = ->
  # Setting up samples
  so =
    name: "Sample JSON"
    age: 298
    married: true
  Session.set "sampleJSON", so
  Session.set "observatory.templateViewer.currentSessionKey", syntaxHighlight(EJSON.stringify(so))
  Session.set "observatory.templateViewer.currentCode", "created = " + Template.templateViewer.created.toString()


Template.templateViewer.rendered = ->
  t = Session.get "observatory.templateViewer.currentTemplate"
  t = 'templateViewer' if not t?
  Session.set "observatory.templateViewer.currentTemplate", t
  $('#templateNames').val(t)
  $('pre code').each (i,e)-> hljs.highlightBlock e

Template.templateViewer.helpers
  currentTemplate: ->
    t = Session.get "observatory.templateViewer.currentTemplate"
    t = 'templateViewer' if not t?
    t
  allTemplates: -> Observatory.getTemplateNames()
  helperNames: (n)->
    #console.log n
    ret = []
    ret.push k for k,v of Observatory.getHelpers n
    ret
  eventNames: (n)->
    #console.log n
    ret = []
    ret.push k for k,v of Observatory.getEvents n
    ret
  currentCode: -> Session.get "observatory.templateViewer.currentCode"
  sessionKeys: ->
    ret = []
    for k, v of Session.keys
      ret.push k unless (k is "observatory.templateViewer.currentSessionKey") or (k is "observatory.templateViewer.currentCode") or (k is "currentLogs")
    ret
  currentSessionKey: -> Session.get "observatory.templateViewer.currentSessionKey"


Template.templateViewer.events
  'change #templateNames': (e)->
    Session.set "observatory.templateViewer.currentTemplate", $('#templateNames').val()

  'mouseenter .function': (e)->
    ct = Session.get "observatory.templateViewer.currentTemplate"
    mn = $(e.target).html()
    code = switch $(e.target).attr('data-method')
      when 'helper' then Observatory.getHelpers(ct)[mn]
      # TODO: The below is a quick fix, in reality need to look at the whole array!!!
      when 'event' then Observatory.getEvents(ct)[mn][0]
      else Template[ct][mn]
    #console.log code
    Session.set "observatory.templateViewer.currentCode", "#{mn} = #{code?.toString() ? 'undefined'}"

  'mouseenter .sessionKey': (e)->
    mn = $(e.target).text()
    tt = Session.get "#{mn}"
    #console.log mn, tt
    Session.set "observatory.templateViewer.currentSessionKey", syntaxHighlight(EJSON.stringify(tt))

