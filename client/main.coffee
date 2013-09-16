Observatory.logMeteor()
if not @logSub?
  #console.log 'subscribing'
  @logSub = Meteor.subscribe Observatory.getMeteorLogger().colName, 50 

