const { Router } = require('express');
const router = Router();
const mysqlConnection = require('../database');
const FoodItem = require('../classes/FoodItem');



router.get('/', (req, res) => {
    res.status(200).json('Server on port 4000 and Database is connected.');
});



router.post('/workout', (req, res) => {
    const { user_id, name, dateOfCreation } = req.body;
    const q = "insert into workout_plans values (DEFAULT,?,?,?);";
    mysqlConnection.query(q, [user_id, name, dateOfCreation], (error, rows, fields) => {
        if (error) {
            console.log(error);
            res.json({ Status: "Failed" });
        } else {
            const q2 = "select w_id from workout_plans where creator = ? AND date_of_creation = ? AND name =?;";
            mysqlConnection.query(q2, [user_id, dateOfCreation, name], (error, rows, fields) => {
                if (error) {
                    console.log(error);
                    res.json({ id: 0 });
                } else {
                    res.json({ id: rows[0]['w_id'] });
                }
            });
        }
    });
});

router.post('/workout/data/:w_id/:e_id/:sets/:day', (req, res) => {
    const w_id = req.params.w_id;
    const e_id = req.params.e_id;
    const day = req.params.day;
    const sets = req.params.sets;

    const q = "insert into daily_workouts values (?,?,?,?);";

    mysqlConnection.query(q, [w_id, e_id, day, sets], (error, rows) => {
        if (error) {
            console.log(error);
            res.json({ Status: "Failed" });
            return;
        } else {
            res.json({ Status: "OK" });
        }
    });
});

router.post('/diet', (req, res) => {
    const { user_id, name, dateOfCreation } = req.body;
    const q = "insert into diet_plans values (DEFAULT,?,?,?);";
    mysqlConnection.query(q, [user_id, dateOfCreation, name], (error, rows, fields) => {
        if (error) {
            console.log(error);
            res.json({ id: 0 });
            return;
        } else {
            const q2 = "select d_id from diet_plans where creator = ? AND date_of_creation = ? AND name =?;";
            mysqlConnection.query(q2, [user_id, dateOfCreation, name], (error, rows, fields) => {
                if (error) {
                    console.log(error);
                    res.json({ id: 0 });
                } else {
                    res.json({ id: rows[(rows.length-1<0)?0:(rows.length-1)]['d_id'] });
                }
            });
        }
    });
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

router.post('/diet/keywords/:d_id/:kw_id', (req, res) => {
    const d_id = req.params.d_id;
    const kw_id = req.params.kw_id;
    const q1 = "insert into diet_keywords values (?,?);";

    mysqlConnection.query(q1, [d_id, kw_id], (error) => {
        if (error) {
            console.log(error);
            res.json({ Status: "Failed" });
            return;
        } else {
            res.json({ Status: "OK" });
        }
    });
});

router.post('/workout/keywords/:w_id/:kw_id', (req, res) => {
    const w_id = req.params.w_id;
    const kw_id = req.params.kw_id;
    const q1 = "insert into workout_keywords values (?,?);";

    mysqlConnection.query(q1, [w_id, kw_id], (error) => {
        if (error) {
            console.log(error);
            res.json({ Status: "Failed" });
            return;
        } else {
            res.json({ Status: "OK" });
        }
    });
});



router.post('/feedback/:user_id/:description', (req, res) => {
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

router.get('/feedback', (req, res) => {
    const q = "select ua.username as username, fb.description as description, fb.upload_time as date from user_authentication ua join feedback fb on(fb.user_id = ua.user_id) order by (fb.upload_time) desc;"
    mysqlConnection.query(q, (error, rows, fields) => {
        if (error) {
            console.log(error);
        } else {
            res.json(rows);
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


router.get('/workout/:user_id', (req, res) => {
    const q1 = "select uw.w_id as id, wp.name as name, uw.Enrollment_Date as enrollmentDate from user_workouts uw Join workout_plans wp ON(uw.w_id = wp.w_id) where uw.user_id = ?;";
    const q2 = "select max(day) as days from daily_workouts where w_id = ?;";
    const user_id = req.params.user_id;

    // var id, name, enrollmentDate, days;

    mysqlConnection.query(q1, [user_id], (error, rows, fields) => {
        if (error) {
            console.log(error);
            res.json({ Status: "unable to get data" });
        } else {
            if (rows.length > 0) {
                const id = rows[0]['id'];
                const name = rows[0]['name'];
                const enrollmentDate = rows[0]['enrollmentDate'];

                mysqlConnection.query(q2, [id], (error, rows, fields) => {
                    if (error) {
                        console.log(error);
                    } else {
                        const days = rows[0]['days'];
                        res.json({
                            "id": id,
                            "name": name,
                            "enrollmentDate": enrollmentDate,
                            "days": days
                        });
                    }
                });
            }
        }
    });
});

router.get('/workout/data/:id', (req, res) => {
    const w_id = req.params.id;
    const q = "SELECT e.e_id AS id, e.name AS name, e.description AS description, " +
              "e.image AS image, bp.name AS bodyPart, bd.name AS bodyDomain, " +
              "et.type_name = 'Push' AS push, eq.name AS equipment, dw.day AS day, " +
              "dw.sets AS sets " +
              "FROM daily_workouts dw " +
              "JOIN exercises e ON(dw.e_id = e.e_id) " +
              "JOIN exercise_type et ON(e.type_id = et.type_id) " +
              "JOIN exercise_equipments eq ON(eq.eq_id = e.eq_id) " +
              "JOIN bodyparts bp ON(bp.bp_id = e.bp_id) " +
              "JOIN body_domain bd ON (bd.dom_id = bp.dom_id) " +
              "WHERE dw.w_id = ?;";

    mysqlConnection.query(q, [w_id], (error, results) => {
        if (error) {
            console.log(error);
            res.status(500).send('Internal Server Error');
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
                    equipment: item.equipment,
                    day: item.day,
                    Sets: item.sets
                };
            });
            res.json(output);
        }
    });
});


router.get('/diet/:user_id', (req, res) => {
    const user_id = req.params.user_id;
    const q1 = "select ud.d_id as id, dp.name as name, ud.Enrollment_Date as enrollmentDate from user_diets ud Join diet_plans dp ON(ud.d_id = dp.d_id) where ud.user_id = ?;";

    mysqlConnection.query(q1, [user_id], (error, rows, fields) => {
        if (error) {
            console.log(error);
            res.json({ error: "Failed to fetch diet information" });
        } else {
            if (rows.length > 0) {
                const row = rows[0];
                const id = row['id'];
                const name = row['name'];
                const enrollmentDate = row['enrollmentDate'];


                res.json({
                    "id": id,
                    "name": name,
                    "enrollmentDate": enrollmentDate
                });
            } else {
                res.json({ error: "No diet information found for the user" });
            }
        }
    });
});

router.get('/diet/data/:id', (req, res) => {
    const d_id = req.params.id;
    const q = "select f.f_id AS id, f.name AS name,f.description AS description, f.image AS image, f.calories AS calories, f.fats AS fats, f.protein AS protein, f.carbohydrates AS carbohydrates,f.fibre as fibre, f.sugar as sugar, m.quantity as quantity ,m.time as time from diet_plans dp Join meals m ON(dp.d_id = m.d_id) Join food_items f ON(f.f_id = m.f_id) where dp.d_id = ?;";

    mysqlConnection.query(q, [d_id], (error, results) => {
        if (error) {
            console.log(error);
        } else {
            const output = results.map(item => {
                const image = item.image ? item.image.toString('base64') : null; // Convert BLOB to base64
                return {
                    id: item.id,
                    name: item.name,
                    description: item.description,
                    image: image,
                    calories: item.calories,
                    fats: item.fats,
                    protein: item.protein,
                    carbohydrates: item.carbohydrates,
                    fibre: item.fibre,
                    sugar: item.sugar,
                    time: item.time,
                    quantity: item.quantity,
                };
            });
            res.json(output);
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

router.post('/keyword/:data', (req, res) => {
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

router.delete('/keyword/:id', (req, res) => {
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

router.get('/keyword', (req, res) => {
    mysqlConnection.query("select kw_id AS id , name from keywords;", (error, rows, fields) => {
        if (error) {
            console.log(error);
        } else {
            res.json(rows);
        }
    });
});

router.post('/request', (req, res) => {
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

router.get('/request', (req, res) => {
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

router.post('/request/id/:r_id/:status', (req, res) => {
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