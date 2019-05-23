const express = require('express');
const bodyParser = require('body-parser');

const app = express();
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
const PORT = process.env.PORT || 3030;

app.post('/flutter-login', (req, res) => {
    //console.log(req.body);
    const userInfo = JSON.parse(JSON.stringify(req.body, null, 2));
    if(userInfo.username == 'baraka') {
        let userData = {
            name: 'Baraka Mahili',
            from: 'Congo'
        }
        res.status(200).json(userData)
    } else {
        res.status(401).json({error: 'You are not authorized'});
    }
});

app.get('/getData', (req, res) => {
    res.status(200).json({name:'Baraka Mahili',from:'Back-End of Flutter'});
});
app.listen(PORT, ()=>console.log('Server is listening on port', PORT));