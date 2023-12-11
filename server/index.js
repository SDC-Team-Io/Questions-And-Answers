require('dotenv').config();
const express = require('express');
const path = require('path');
const router = require("./router.js");


const app = express();

app.use(express.json());
app.use(express.static(path.join(__dirname, './public/dist')));

app.use('/', router);

const PORT = process.env.PORT || 3005;
app.listen(PORT);