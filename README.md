What is it?
-------------
This is a Telescope Logger (soon-to-be-a) package that provides simple, efficient and pretty logging for the [Meteor framework](http://meteor.com). 
Screenshot: ![Telescope Logs screenshot](https://github.com/jhoxray/telescope/blob/master/pub/telescope.png)
[Live demo app](http://http://telescope-logger.meteor.com)

Why?
------
I got frustrated with the need to switch between the terminal and Chrome's js console to keep track of Meteor app logs, plus needed a basic standard logging package that can support different log levels and present all that in one place in a nice format.

What does it do?
------------------
Supports different log levels (currently FATAL, ERROR, WARNING, INFO, VERBOSE) with corresponding methods for message output, optional logging to console, pretty output of both Client and Server logs using Twitter Bootstrap right in the browser.

Usage
------------
To display the logs, just plugin logs_bootstrap Handlebars template anywhere in your html pages. E.g., in this app it's in the column to the right.



