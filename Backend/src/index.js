const express = require('express');
const cors = require('cors');
const app = express();

app.use(cors());

const bodyParser = require('body-parser');
app.use(bodyParser.json({ limit: '10mb' }));

// Settings
app.set('port', process.env.PORT || 4000);

// Middlewares
app.use(express.json());

// Routes
app.use(require('./routes/user'));
app.use('/workout',require('./routes/workout'));
app.use('/diet',require('./routes/diet'));
app.use('/keyword',require('./routes/keyword'));
app.use('/feedback',require('./routes/feedback'));
app.use('/request',require('./routes/request'));

// Starting the server
app.listen(app.get('port'), () => {
    console.log('Server on port', app.get('port'));
});

