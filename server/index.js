const port = 3000;
const process = require('process');
const os = require("os");

const http = require("http");

http
   .createServer(function(request, response){
       console.log(`${request.method} request on ${request.url}`);
       response.writeHead(200, {'Content-Type': 'text/plain'});
       response.end(`Hello World from process ${process.pid} at ${os.hostname()}\n`, "utf-8")
   })
   .listen(port);
console.log(`Server bound to 'localhost:${port}'`);
