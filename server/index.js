const express = require('express');
const bodyParser = require('body-parser');

const app = express();
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
const PORT = process.env.PORT || 3030;

app.post('/flutter-login', (req, res) => {
    console.log(req.body);
})
app.listen(PORT, ()=>console.log('Server is listening on port', PORT));