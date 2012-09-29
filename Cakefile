#read https://github.com/jashkenas/coffee-script/wiki/[HowTo]-Compiling-and-Setting-Up-Build-Tools for more
sys = require 'sys'
fs = require 'fs'
exec = require('child_process').exec
spawn = require('child_process').spawn

task 'build', 'Build project from src/*.coffee to lib/*.js', ->
  exec 'coffee --compile --output lib/ src/', (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr

task 'deploy', 'deploy sample app to telescope-logger.meteor.com', ->
	exec '"../meteor/meteor" deploy telescope-logger.meteor.com', (err, stdout,stderr) ->
    	throw err if err
    	console.log stdout + stderr


task 'run', 'run app locally', ->
  exec '../meteor/meteor', (err, stdout,stderr) ->
    throw err if err
    console.log stdout + stderr
