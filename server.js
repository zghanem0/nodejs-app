'use strict';

const express = require('express');
// Constants
const PORT = 7777;
const HOST = '0.0.0.0';  //local host
// App
const app = express();
app.get('/', (req, res) => {
  res.send('welcome to ghanem Ci/CD Pipline:) \n');
});
app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
