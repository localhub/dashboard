net = require 'net'
readline = require 'readline'
controlSock = new net.Socket {
	fd: 3, readable: true, writable: true
}
control = readline.createInterface controlSock, controlSock

express = require 'express'
app = express()

app.use (express.static __dirname + '/public')

server = app.listen 0, '127.0.0.1', ->
	controlSock.write JSON.stringify {
		proxy: this.address().port
	}
	controlSock.write '\n'
