net = require 'net'
controlSock = new net.Socket {
	fd: 3, readable: true, writable: true
}
controlSock.on 'error', ->

express = require 'express'
app = express()

app.use (express.static __dirname + '/public')

server = app.listen 0, '127.0.0.1', ->
	controlSock.write JSON.stringify {
		proxy: this.address().port
	}
	controlSock.write '\n'
