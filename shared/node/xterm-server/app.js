var express = require('express');
var app = express();
var expressWs = require('express-ws')(app);
var os = require('os');
var pty = require('node-pty');
var cors = require('cors');
var terminals = {},
    logs = {};

app.use(cors());

app.post('/terminals', function (req, res) {
  var cols = parseInt(req.query.cols),
      rows = parseInt(req.query.rows),
      term = pty.spawn(process.platform === 'win32' ? 'cmd.exe' : 'bash', [], {
        name: 'xterm-color',
        cols: 120,
        rows: 40,
        cwd: process.env.PWD,
        env: process.env
      });

  console.log('Created terminal with PID: ' + term.pid);
  terminals[term.pid] = term;
  logs[term.pid] = '';
  term.on('data', function(data) {
    logs[term.pid] += data;
  });
  res.send(term.pid.toString());
  res.end();
});

app.ws('/terminals/:pid', function(ws, req) {
  var term = terminals[parseInt(req.params.pid)];
  console.log('Conneted to terminal ' + term.pid);
  ws.send(logs[term.pid]);

  term.on('data', function(data) {
    try {
      ws.send(data)
    } catch(ex) {
    }
  });

  ws.on('message', function(msg) {
    term.write(msg)
  });

  ws.on('close', function() {
    term.kill();
    delete terminals[term.pid]
    delete logs[term.pid]
  });

});

var port = process.env.PORT || 8081
    host = os.platform() === 'win32' ? '127.0.0.1' : '0.0.0.0';

console.log('App listening to http://' + host + ':' + port);
app.listen(port, host);
