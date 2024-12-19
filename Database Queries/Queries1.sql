select * from user_authentication;
select * from exercises;
SELECT f_id AS id,name,description,image,calories,fats,protein,carbohydrates,fibre,sugar
FROM food_items;
select * from workout_keywords;
UPDATE user_diets
SET enrollment_date = current_date()
where user_id>0;
select * from diet_Keywords;
insert into user_workouts (USER_ID,w_ID) values (2,1);
select * from keywords;
SELECT 
    e.e_id id,
    e.name AS name,
    e.description AS description,
    e.image AS image,
    bp.name AS bodyPart,
    bd.name AS bodyDomain,
    (type_name = 'Push') AS push,
    eq.name AS equipment
FROM
    Exercises e
        JOIN
    exercise_type et ON e.type_id = et.type_id
        JOIN
    exercise_equipments eq ON eq.eq_id = e.eq_id
        JOIN
    Bodyparts bp ON e.bp_id = bp.bp_id
        JOIN
    body_domain bd ON bd.dom_id = bp.dom_id
WHERE
    bd.name = '';


Drop table user_diets;

ALTER TABLE user_diets
DROP CONSTRAINT user_diets_primary_key;

-- Step 2: Add a new primary key constraint on user_id
ALTER TABLE user_diets
ADD PRIMARY KEY (user_id);
    