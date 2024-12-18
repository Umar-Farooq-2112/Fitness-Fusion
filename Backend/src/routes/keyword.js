const { Router } = require('express');
const router = Router();
const mysqlConnection = require('../database');

router.post('/:data', (req, res) => {
    const data = req.params.data;
    mysqlConnection.query("Insert into keywords values (DEFAULT,?);", [data], (error, rows, fields) => {
        if (error) {
            console.log(error);
            res.json({ Status: "Failed" });
        } else {
            res.json({ Status: "OK" });
        }
    });

});

router.delete('/:id', (req, res) => {
    const id = req.params.id;
    mysqlConnection.query("delete from keywords where kw_id = ?;", [id], (error, rows, fields) => {
        if (error) {
            console.log(error);
            res.json({ Status: "Failed" });
        } else {
            res.json({ Status: "OK" });
        }
    });

});

router.get('/', (req, res) => {
    mysqlConnection.query("select kw_id AS id , name from keywords;", (error, rows, fields) => {
        if (error) {
            console.log(error);
        } else {
            res.json(rows);
        }
    });
});

module.exports = router;