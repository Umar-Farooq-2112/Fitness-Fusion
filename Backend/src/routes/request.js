const { Router } = require('express');
const router = Router();
const mysqlConnection = require('../database');

router.post('/', (req, res) => {
    const { username, password, name, gender, height, weight, date_of_birth, email, contact } = req.body;
    const q = "Insert into requests values (Default,?,?,?,?,?,?,?,?,?);";

    mysqlConnection.query(q, [username, password, name, gender, height, weight, date_of_birth, email, contact], (error, rows, fields) => {
        if (error) {
            console.log(error);
            res.json({ Status: "Failed" });
        } else {
            res.json({ Status: "OK" });
        }
    });
});

router.get('/', (req, res) => {
    const q = "Select r_id,username,name,gender,height,weight,date_of_birth,email,contact from requests;";

    mysqlConnection.query(q, (error, results) => {
        const output = results.map(
            (item) => {
                return {
                    id: item.r_id,
                    username: item.username,
                    name: item.name,
                    gender: item.gender,
                    height: item.height,
                    weight: item.weight,
                    date_of_birth: item.date_of_birth,
                    email: item.email,
                    contact: item.contact
                };
            }
        );
        res.json(output);
    });
});

router.post('//id/:r_id/:status', (req, res) => {
    const r_id = req.params.r_id;
    const status = req.params.status;

    if (status == 0) {
        const q = "Delete from requests where r_id = ?";

        mysqlConnection.query(q, [r_id], (error, rows, fields) => {
            if (error) {
                console.log(error);
                res.json({ Status: "Failed" });
            } else {
                res.json({ Status: "OK" });
            }
            return;
        });
    } else if (status == 1) {
        let username, password, name, gender, height, weight, date_of_birth, email, contact;

        mysqlConnection.query("Select username,password,name,gender,height,weight,date_of_birth,email,contact from requests where r_id = ?", [r_id], (error, rows, fields) => {
            if (error) {
                console.log(error);
                res.json({ Status: "Failed" });
                return;
            } else {
                username = rows[0]['username'];
                password = rows[0]['password'];
                name = rows[0]['name'];
                gender = rows[0]['gender'];
                height = rows[0]['height'];
                weight = rows[0]['weight'];
                date_of_birth = rows[0]['date_of_birth'];
                email = rows[0]['email'];
                contact = rows[0]['contact'];

                const q1 = 'INSERT INTO user_authentication VALUES (?,DEFAULT,?,(SELECT t_id FROM user_types WHERE name = ?));';
                const q2 = 'INSERT INTO user_info VALUES ((SELECT user_id FROM user_authentication WHERE username = ?),?,?,?,?,?,?,?);';
                const usertype = "Trainer";

                mysqlConnection.query(q1, [username, password, usertype], (error, rows, fields) => {
                    if (error) {
                        console.log(error);
                        return res.status(500).json({ error: "Error in user_authentication insertion" });
                    }

                    mysqlConnection.query(q2, [username, name, gender, height, weight, date_of_birth, email, contact], (error, rows, fields) => {
                        if (error) {
                            console.log(error);
                            return res.status(500).json({ error: "Failed" });
                        }
                        const q3 = "delete from requests where r_id = ?;";
                        mysqlConnection.query(q3, [r_id], (error) => {
                            if (error) {
                                console.log(error);
                                return res.status(500).json({ error: "Failed" });
                            }
                            res.json({ Status: "OK" });
                        });
                    });
                });
            }
        });
    }
});

module.exports = router;