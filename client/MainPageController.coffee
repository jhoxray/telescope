class @MainPageController extends RouteController
  template: 'main'

  renderTemplates:
    'sidebar': to: 'sidebar'
    'footer': to: 'footer'

  data: ->
    #console.log @params
    Session.set "activeMain", @params.module
    #cc.logs = Observatory.getMeteorLogger()._logsCollection
    activeModule: @params.module

  @active: (module) ->
    #console.log "active called for " + module
    ret = Session.equals "activeMain", module
    #console.log "returning " + ret
    if ret then 'active' else ''




Template.main.moduleBanners =
  apollo: "<a href='/main/apollo'>Observatory: Apollo.</a> Foundational javascript framework for logging and monitoring <a href='http://meteor.com'>Meteor</a>, node.js and the browser."
  jupiter: "<a href='/main/jupiter'>Observatory: Jupiter.</a> Automagical logging, profiling and introspection to simplify your <a href='http://meteor.com'>Meteor</a> development. Installs and runs locally."
  vega: "<a href='/main/vega'>Observatory: Vega.</a> Full-featured, powerful and easy to use cloud application management and monitoring for your <a href='http://meteor.com'>Meteor</a> apps. Including <em>localhost</em>."
  main: "<a href='/'>Observatory Suite.</a> Logging, monitoring, visual instrospection and apllication management for <a href='http://meteor.com'>Meteor</a> framework."

Template.main.mainBadges =
  main: new Handlebars.SafeString(Template.main_telescope())
  jupiter: new Handlebars.SafeString(Template.sample_app())
  vega: new Handlebars.SafeString(Template.vega_badge())
  apollo: new Handlebars.SafeString(Template.apollo_badge())

Template.main.helpers
  active: MainPageController.active
  activeImage: ->
    module = Session.get "activeMain"
    switch module
      when 'apollo' then '/moon1.png'
      when 'jupiter' then '/jupiter.png'
      when 'vega' then '/vega.png'

  moduleBanner: (name)->
    if name? then Template.main.moduleBanners[name] else Template.main.moduleBanners.main

  mainBadge: (name)->
    if name? then Template.main.mainBadges[name] else Template.main.mainBadges.main



Template.layout.helpers
  active: MainPageController.active

Template.layout.events
  "mouseenter ul.modules-navs li": (e)->
    t = e.target.innerText
    ###
    console.log t
    switch t.trim()
      when 'apollo' then console.log '/moon1.png'
      when 'jupiter' then console.log  '/jupiter.png'
      when 'vega' then console.log '/vega.png'
    ###


Template.main.events
  "click .btnSA": (evt, tmpl)->
    source = $("#server_or_client").val()
    i = parseInt evt.target.getAttribute("severity")
    msg = $("#log_message").val()

    #console.log "pressed button #{msg} level #{i}"
    if !msg
      k = Math.floor((Math.random()*6))
      msg = tmpl.random_messages[k]

    if source is "client"
      #easy, simply calling log function. BTW, DON'T use _log in your apps, it's a private method :)
      TL._emitWithSeverity(i, msg, null, 'user')

    else
      #tricky, need to call an actual method on the server so that the message logs with correct source
      #of course we could simply override the setting, but where's the fun in that?
      Meteor.call("log_remote",msg,i)
    $("#log_message").val ""

Template.main.rendered = ->
  $('pre code').each (i,e)-> hljs.highlightBlock e


Template.main.created = ->
  @random_messages = [
    "Ah! Trying to trick the system?"
    "Come on! You can do better than that!"
    "boh-ring..."
    "There's only so many random messages, so start typing"
    "This is a log message"
    "Observatory is a very cool package!"
  ]

