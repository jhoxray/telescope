What is it?
-------------
This is Telescope Logger - (soon-to-be-a) package that provides simple, efficient and pretty logging for the [Meteor framework](http://meteor.com). 

Why?
------
We got frustrated with the need to switch between the terminal and Chrome's js console to keep track of the Meteor app logs, plus needed a basic standard logging package that can support different log levels and present all that in one place in a nice format.

What does it do?
------------------
Supports different log levels (currently FATAL, ERROR, WARNING, INFO, VERBOSE) with corresponding methods for message output, optional logging to console, pretty output of both Client and Server logs using Twitter Bootstrap right in the browser.

[See for yourself!](http://telescope-logger.meteor.com)

Installation
------------
This is version 0.1 that indeed can be used for your development with Meteor. However, there's no fancy installation at this point - basically, you just need to copy a "lib" directory from this repo into your project and you should be set. Current version is done 
with the ["auth" branch of meteor](https://github.com/meteor/meteor/wiki/Getting-Started-with-Auth), if you want to use it with master 4.1, just kill _global_logs.allow call in telescope.coffee. 
Mind the dependencies, before it's automated do at least:

	meteor add accounts-ui //optional, only with auth, but if you use it you probably added it anyway
	meteor add bootstrap
	meteor add less
	meteor add coffeescript
	meteor add underscore
	//optional, but recommended:
	meteor remove autopublish
	meteor remove insecure

Yes, we'll make it easier in the future.

Usage
---------
Somewhere in the common code of your meteor app call:
```coffeescript
TL = new TLog(TLog.LOGLEVEL_MAX,true)
#for other options, see API section below
```
and then when you want to log a message of a certain log level:
```coffeescript
TL.fatal("your message")
TL.error("your message")
TL.warn("your message")
TL.info("your message")
TL.verbose("your message")
```
To actually display the logs, plugin "logs_bootstrap" template anywhere in your Handlebars templates. E.g.:
```html
<div class="span8">
  <h1>My cool logs</h1>

  {{>logs_bootstrap}}
</div>
```

Everything else is done automagically, as always is the case with Meteor. See how it's done in this sample app and how it looks in the [live demo](http://telescope-logger.meteor.com).


API
---------
In addition to the functions above here's a short description of what else you may need.
```coffeescript
class TLog
  #setting desired log level and whether you also want to output your log messages to the console (true or false)
  constructor: (@_currentLogLevel, @_printToConsole)
  
  #log levels are defined as follows, so use TLog.LOGLEVEL_... when instantiating
  @LOGLEVEL_FATAL = 0
  @LOGLEVEL_ERROR = 1
  @LOGLEVEL_WARNING = 2
  @LOGLEVEL_INFO = 3
  @LOGLEVEL_VERBOSE = 4
  @LOGLEVEL_MAX = 5

  #to change log level and console printing, use
  setOptions: (loglevel, want_to_print = true)
```

Feedback
----------
We'd love to hear what you think, whether it's useful and which other features you'd want to see in a proper Meteor logging framework - so please use the [issues mechanism](https://github.com/jhoxray/telescope/issues) here on github to share your thoughts and ideas!

