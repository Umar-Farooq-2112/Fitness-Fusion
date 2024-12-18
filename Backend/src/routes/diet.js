const { Router } = require('express');
const router = Router();
const mysqlConnection = require('../database');
const FoodItem = require('../classes/FoodItem');


router.post('/', (req, res) => {
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
router.post('/keywords/:w_id', (req, res) => {
    const w_id = req.params.w_id; // Get workout ID from URL
    const keywords = req.body.ids; // Extract keywords from JSON body

    if (!keywords || !Array.isArray(keywords) || keywords.length === 0) {
        res.status(400).json({ Status: "Failed", Message: "Invalid or empty keywords list" });
        return;
    }

    const q1 = "INSERT INTO diet_keywords (d_id, kw_id) VALUES (?, ?);";

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

router.get('/data/:id', (req, res) => {
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

router.post('/match/:user_id', (req, res) => {
    const user_id = req.params.user_id;
    const { ids } = req.body; 
    console.log(ids)
    if (!ids || !Array.isArray(ids) || ids.length === 0) {
        return res.status(400).json({ Status: "Failed", Message: "Invalid or empty keyword IDs" });
    }

    // Query to count the matching keywords per workout ID
    const query = `
        SELECT d_id, COUNT(*) as match_count
        FROM diet_keywords
        WHERE kw_id IN (?)
        GROUP BY d_id
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
            return res.status(404).json({ Status: "Failed", Message: "No matching Diet plan found" });
        }

        // Extract the w_id with the maximum match
        const { d_id, match_count } = results[0];
        console.log(`Best match d_id: ${d_id} with ${match_count} matching keywords`);

        // Your final query (replace this with your actual query logic)
        const finalQuery = `INSERT INTO USER_DIETS (user_id,d_id,Enrollment_Date) VALUES (?,?,current_date())`; // Example final query
        mysqlConnection.query(finalQuery, [user_id,d_id], (finalError, finalResults) => {
            if (finalError) {
                console.error('Final query error:', finalError);
                return res.status(500).json({ Status: "Failed", Message: "Final query failed" });
            }

            // Respond with the final results
            res.json({
                Status: "OK",
                Message: `Best matching workout plan found with d_id ${d_id}`,
                Data: finalResults,
            });
        });
    });
});


module.exports = router;