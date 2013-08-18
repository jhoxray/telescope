ObservatorySettings =
  #this is in a publish function, remember you would need to use this.userId instead of Meteor.user()
  should_publish: () -> true

(exports ? this).ObservatorySettings = ObservatorySettings