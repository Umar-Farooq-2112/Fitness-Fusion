const { Router } = require('express');
const router = Router();
const mysqlConnection = require('../database');

router.post('/', (req, res) => {
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

router.post('/data/:w_id/:e_id/:sets/:day', (req, res) => {
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


router.post('/keywords/:w_id', (req, res) => {
    const w_id = req.params.w_id; // Get workout ID from URL
    const keywords = req.body.ids; // Extract keywords from JSON body

    
    if (!keywords || !Array.isArray(keywords) || keywords.length === 0) {
        res.status(400).json({ Status: "Failed", Message: "Invalid or empty keywords list" });
        return;
    }

    const q1 = "INSERT INTO workout_keywords (w_id, kw_id) VALUES (?, ?);";

    // Process each keyword
    const queries = keywords.map((kw_id) => {
        return new Promise((resolve, reject) => {
            mysqlConnection.query(q1, [w_id, kw_id], (error) => {
                if (error) {
                    reject(error);
                } else {
                    resolve();
                }
            });
        });
    });

    // Execute all queries
    Promise.all(queries)
        .then(() => {
            console.log("All Keywords Added");
            res.json({ Status: "OK" });
        })
        .catch((error) => {
            console.log(error);
            res.status(500).json({ Status: "Failed", Error: error.message });
        });
});
router.get('/:user_id', (req, res) => {
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
            else{
                res.json('Status: Empty');
            }
        }
    });
});

router.get('/data/:id', (req, res) => {
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


router.post('/match/:user_id', (req, res) => {
    const user_id = req.params.user_id;
    const { ids } = req.body; 
    console.log(ids)
    if (!ids || !Array.isArray(ids) || ids.length === 0) {
        return res.status(400).json({ Status: "Failed", Message: "Invalid or empty keyword IDs" });
    }

    // Query to count the matching keywords per workout ID
    const query = `
        SELECT w_id, COUNT(*) as match_count
        FROM workout_keywords
        WHERE kw_id IN (?)
        GROUP BY w_id
        ORDER BY match_count DESC
        LIMIT 1;
    `;

    // Execute the query with the provided keyword IDs
    mysqlConnection.query(query, [ids], (error, results) => {
        if (error) {
            console.error('Database error:', error);
            return res.status(500).json({ Status: "Failed", Message: "Database query failed" });
        }

        if (results.length === 0) {
            return res.status(404).json({ Status: "Failed", Message: "No matching workout plan found" });
        }

        // Extract the w_id with the maximum match
        const { w_id, match_count } = results[0];
        console.log(`Best match w_id: ${w_id} with ${match_count} matching keywords`);

        // Your final query (replace this with your actual query logic)
        const finalQuery = `INSERT INTO USER_WORKOUTS (user_id,w_id,Enrollment_Date) VALUES (?,?,current_date())`; // Example final query
        mysqlConnection.query(finalQuery, [user_id,w_id], (finalError, finalResults) => {
            if (finalError) {
                console.error('Final query error:', finalError);
                return res.status(500).json({ Status: "Failed", Message: "Final query failed" });
            }

            // Respond with the final results
            res.json({
                Status: "OK",
                Message: `Best matching workout plan found with w_id ${w_id}`,
                Data: finalResults,
            });
        });
    });
});


module.exports = router;