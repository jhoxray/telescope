ObservatorySettings =
  #this is in a publish function, remember you would need to use this.userId instead of Meteor.user()
  should_publish: () -> true
  logLevel: 6
  printToConsole: true
  log_user: true
  log_http: true

(exports ? this).ObservatorySettings = ObservatorySettings