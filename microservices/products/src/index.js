const http = require('http');
const app = require('./app');

const port = process.env.PORT || 3004;
const server = http.createServer(app);
server.listen(port, () => console.log(`Server running port ${port}`));
