select * from user_authentication;

SELECT f_id AS id,name,description,image,calories,fats,protein,carbohydrates,fibre,sugar
FROM food_items;

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