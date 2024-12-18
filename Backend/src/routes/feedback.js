const { Router } = require('express');
const router = Router();
const mysqlConnection = require('../database');


router.post('/:user_id/:description', (req, res) => {
    const user_id = req.params.user_id;
    const description = req.params.description;

    const q = "insert into feedback values (?,?,current_timestamp());";
    mysqlConnection.query(q, [user_id, description], (error, rows, fields) => {
        if (error) {
            console.log(error);
            res.json({ Status: "Failed" });
        } else {
            res.json({ Status: "OK" });
        }
    });



});

router.get('/', (req, res) => {
    const q = "select ua.username as username, fb.description as description, fb.upload_time as date from user_authentication ua join feedback fb on(fb.user_id = ua.user_id) order by (fb.upload_time) desc;"
    mysqlConnection.query(q, (error, rows, fields) => {
        if (error) {
            console.log(error);
        } else {
            res.json(rows);
        }
    });
});

module.exports  = router;