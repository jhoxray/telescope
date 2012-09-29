What is it?
-------------
This is Telescope Logger - (soon-to-be-a) package that provides simple, efficient and pretty logging for the [Meteor framework](http://meteor.com). 

Why?
------
We got frustrated with the need to switch between the terminal and Chrome's js console to keep track of the Meteor app logs, plus needed a basic standard logging package that can support different log levels and present all that in one place in a nice format.

What does it do?
------------------
Supports different log levels (currently FATAL, ERROR, WARNING, INFO, VERBOSE) with corresponding methods for message output, optional logging to console, pretty output of both Client and Server logs using Twitter Bootstrap right in the browser.

[See for yourself!](http://http://telescope-logger.meteor.com)

Usage
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

```ruby
require 'redcarpet'
markdown = Redcarpet.new("Hello World!")
puts markdown.to_html
```



