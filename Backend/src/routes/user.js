const { Router } = require('express');
const router = Router();
const mysqlConnection = require('../database');
const FoodItem = require('../classes/FoodItem');



router.get('/', (req, res) => {
    res.status(200).json('Server on port 4000 and Database is connected.');
});




router.post('/meal/:f_id/:quantity/:d_id/', (req, res) => {
    const f_id = req.params.f_id;
    const quantity = req.params.quantity;
    const d_id = req.params.d_id;
    const { time } = req.body;

    const q1 = "insert into meals values (?,?,?,?);";

    mysqlConnection.query(q1, [f_id, quantity, time, d_id], (error) => {
        if (error) {
            console.log(error);
            res.json({ Status: "Failed" });
            return;
        } else {
            res.json({ Status: "OK" });
        }
    });
});




router.put('/userdata/name/:user_id/:name', (req, res) => {
    const user_id = req.params.user_id;
    const name = req.params.name;

    const q = "update user_info set name = ? where user_id = ?";

    mysqlConnection.query(q, [name, user_id], (error, rows, fields) => {
        if (error) {
            console.log(error);
            res.json({ Status: "Failed" });
        } else {
            res.json({ Status: "OK" });
        }
    });
});

router.put('/userdata/:user_id/:weight/:height', (req, res) => {
    const user_id = req.params.user_id;
    const weight = req.params.weight;
    const height = req.params.height;

    const q = "update user_info set height = ?, weight = ? where user_id = ?";

    mysqlConnection.query(q, [height, weight, user_id], (error, rows, fields) => {
        if (error) {
            console.log(error);
            res.json({ Status: "Failed" });
        } else {
            res.json({ Status: "OK" });
        }
    });
});

router.put('/password/:user_id/:password', (req, res) => {
    const user_id = req.params.user_id;
    const password = req.params.password;
    const q = "UPDATE user_authentication SET password = ? WHERE user_id = ?;";

    mysqlConnection.query(q, [password, user_id], (error, rows, fields) => {
        if (error) {
            console.log(error);
            res.json({ Status: "Failed" });
        } else {
            res.json({ Status: "OK" });
        }
    });
});




router.get('/fooditems', (req, res) => {
    const query = 'SELECT f_id AS id,name, description,image,calories,fats,protein,carbohydrates,fibre,sugar FROM food_items';
    mysqlConnection.query(query, (err, results) => {
        if (err) {
            console.error('Error executing MySQL query:', err);
            res.status(500).json({ error: 'Internal Server Error' });
        } else {
            const foodItems = results.map(item => new FoodItem(
                item.id,
                item.name,
                item.description,
                item.image,
                item.calories,
                item.fats,
                item.protein,
                item.carbohydrates,
                item.fibre,
                item.sugar
            ));
            res.json(foodItems);
        }
    });
});

router.get('/exercises/domain/:domain', (req, res) => {
    const temp = req.params.domain;
    const query = "SELECT  e.e_id id, e.name AS name, e.description AS description, e.image AS image, bp.name AS bodyPart, bd.name AS bodyDomain, (type_name = 'Push') AS push, eq.name AS equipment FROM Exercises e JOIN exercise_type et ON e.type_id = et.type_id JOIN exercise_equipments eq ON eq.eq_id = e.eq_id JOIN Bodyparts bp ON e.bp_id = bp.bp_id JOIN body_domain bd ON bd.dom_id = bp.dom_id WHERE bd.name = ?;";

    mysqlConnection.query(query, temp, (err, results) => {
        if (err) {
            console.error('Error executing MySQL query:', err);
            res.status(500).json({ error: 'Internal Server Error' });
        } else {
            const output = results.map(item => {
                const image = item.image ? item.image.toString('base64') : null; // Convert BLOB to base64
                return {
                    id: item.id,
                    name: item.name,
                    description: item.description,
                    image: image,
                    bodyPart: item.bodyPart,
                    bodyDomain: item.bodyDomain,
                    push: item.push,
                    equipment: item.equipment
                };
            });
            res.json(output);
        }
    });
});

router.post('/fooditems', (req, res) => {
    const { name, description, image, calories, fats, protein, carbohydrates, fibre, sugar } = req.body;

    try {
        const base64Data = image.replace(/^data:image\/\w+;base64,/, '');
        // Create a buffer from the Base64 data
        const img = Buffer.from(base64Data, 'base64');

        mysqlConnection.query(
            'INSERT INTO Food_Items (name, description, image, calories, fats, protein, carbohydrates, fibre, sugar) VALUES (?,?,?,?,?,?,?,?,?);',
            [name, description, img, calories, fats, protein, carbohydrates, fibre, sugar],
            (error, rows, fields) => {
                if (error) {
                    console.error(error);
                    res.status(500).json({ status: 'Failed', error: error.message });
                } else {
                    res.status(200).json({ status: 'OK' });
                }
            }
        );
    } catch (error) {
        console.error(error);
        res.status(500).json({ status: 'Failed', error: error.message });
    }
});

router.post('/exercise', (req, res) => {
    const { name, description, image, bodyPart, type, equipment } = req.body;

    // const img = Buffer.from(image, 'base64');

    const base64Data = image.replace(/^data:image\/\w+;base64,/, '');

    // Create a buffer from the Base64 data
    const img = Buffer.from(base64Data, 'base64');

    const q = "INSERT INTO exercises VALUES (DEFAULT, ?,?,?,(Select bp_id from bodyparts where name = ?),(SELECT type_id from exercise_type where type_name = ?),(SELECT eq_id from exercise_equipments where name  = ?));";
    mysqlConnection.query(q, [name, description, img, bodyPart, type, equipment], (error, rows, fields) => {
        if (error) {
            console.log(error);
            res.json({ Status: "Failed" });
        } else {
            res.json({ Status: "OK" });
        }
    });
});

router.get('/authenticate/:username/:password', (req, res) => {

    try {
        mysqlConnection.query('select user_id from user_authentication where username = ? AND password = ?;', [req.params.username, req.params.password], (error, rows, fields) => {

            if (rows.length > 0) {
                const userId = rows[0].user_id;
                res.json({ user_id: userId });
                return;
            }
            res.json({ user_id: 0 });
        })
    } catch (error) {
        console.log(error);
    }
});

router.get('/userdata/:user_id', (req, res) => {
    const user_id = req.params.user_id;
    const q = "SELECT ua.user_id AS user_id,ua.username AS username,ua.password AS password,ui.name AS name,ui.gender AS gender,ui.weight AS weight,ui.height AS height,ui.date_of_Birth AS dateOfBirth,ut.name AS type, ui.email AS email, ui.contact AS contact FROM User_Authentication ua JOIN User_info ui ON (ua.user_id = ui.user_id) Join user_types ut ON (ut.t_id = ua.user_type) where ui.user_id = ?;";
    try {
        mysqlConnection.query(q, [user_id], (error, rows, fields) => {
            if (error) {
                console.log(error);
            } else {
                res.json(rows[0]);
            }
        });
    } catch (error) {
        console.log(error);
    }
});


router.get('/validate/:username', (req, res) => {
    const username = req.params.username;
    const query = "SELECT user_id FROM user_authentication WHERE username = ?;";
    mysqlConnection.query(query, [username], (error, rows, fields) => {
        if (error) {
            console.log(error);
            res.status(500).json({ error: "Internal Server Error" });
        } else {
            if (rows.length > 0) {
                const result = rows[0].user_id;
                res.json({ user_id: result });
            }
            else {
                res.json({ user_id: 0 });
            }
        }
    });
});

router.post('/registration', (req, res) => {
    const { username, password, usertype, name, gender, height, weight, dateOfBirth, email, contact } = req.body;
    const q1 = 'INSERT INTO user_authentication VALUES (?,DEFAULT,?,(SELECT t_id FROM user_types WHERE name = ?));';
    const q2 = 'INSERT INTO user_info VALUES ((SELECT user_id FROM user_authentication WHERE username = ?),?,?,?,?,?,?,?);';

    try {
        mysqlConnection.query(q1, [username, password, usertype], (error, rows, fields) => {
            if (error) {
                console.log(error);
                return res.status(500).json({ error: "Error in user_authentication insertion" });
            }

            // Continue with the second query after the first one is successful
            mysqlConnection.query(q2, [username, name, gender, height, weight, dateOfBirth, email, contact], (error, rows, fields) => {
                if (error) {
                    console.log(error);
                    return res.status(500).json({ error: "Error in user_info insertion" });
                }

                res.json({ Status: "User Added" });
            });
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: "Internal Server Error" });
    }
});

router.get("/registered/plan/:user_id", (req, res) => {
    const userId = req.params.user_id;

    const query = `SELECT 
    CASE 
        WHEN EXISTS (SELECT 1 FROM user_diets WHERE user_id = ?)
             AND EXISTS (SELECT 1 FROM user_workouts WHERE user_id = ?)
        THEN TRUE
        ELSE FALSE
    END AS user_exists;
    `;

    mysqlConnection.query(query, [userId, userId], (err, result) => {
        if (err) {
            return res.status(500).json({ error: 'Database query failed', details: err });
        }

        if (result && result.length > 0) {
            return res.json({ exists: result[0].user_exists });
        } else {
            return res.json({ exists: false });
        }
    });
});



module.exports = router;