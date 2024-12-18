Insert into food_items values
(1,'food1','food1description',load_file('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/img.png'),12,13,14,15,16,17);
Insert into food_items (name, description, image, calories, fats, protein, carbohydrates, fibre, sugar) values
('food1','food1description',load_file('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/img.png'),12,13,14,15,16,17);
Insert into keywords values (DEFAULT,'Bulking'),(DEFAULT,'Shredding');
Insert into exercises values
(1,'benchpress','bp desc',load_file('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/img.png'),2,1,3);
insert into user_diets values (3,2,'2015-05-05');
insert into user_workouts values (3,7,'2015-05-05');

-- select ud.d_id as id, dp.name as name, ud.Enrollment_Date as enrollmentDate from user_diets ud Join diet_plans dp ON(ud.d_id = dp.d_id) where ud.user_id = 3;

-- SELECT  e.e_id id, e.name AS name, e.description AS description, e.image AS image, bp.name AS bodyPart, bd.name AS bodyDomain, (type_name = 'Push') AS push, eq.name AS equipment FROM Exercises e JOIN exercise_type et ON e.type_id = et.type_id JOIN exercise_equipments eq ON eq.eq_id = e.eq_id JOIN Bodyparts bp ON e.bp_id = bp.bp_id JOIN body_domain bd ON bd.dom_id = bp.dom_id WHERE bd.name = 'shoulder';
-- select * from food_items;
-- select * from feedback;
-- Select * from user_types;
-- select user_id from user_authentication where username = 'mok'AND password = 'pass';
-- select * from user_authentication;
-- select * from user_info;
-- SELECT  e.e_id id, e.name AS name, e.description AS description, e.image AS image, bp.name AS bodyPart, bd.name AS bodyDomain, (type_name = 'Push') AS push, eq.name AS equipment FROM Exercises e JOIN exercise_type et ON e.type_id = et.type_id JOIN exercise_equipments eq ON eq.eq_id = e.eq_id JOIN Bodyparts bp ON e.bp_id = bp.bp_id JOIN body_domain bd ON bd.dom_id = bp.dom_id;
-- Select * from keywords;
-- Select * from body_domain;
-- Select * from bodyparts;
-- Select * from exercise_equipments;
-- Select * from exercise_type;
-- select * from requests;
-- delete from keywords where name = 'Shredding';
-- select * from meals;
-- select * from user_diets;
-- select * from diet_plans;
-- select * from meals;
-- select * from workoudaily_workoutst_plans;
-- select * from user_workouts;
-- select * from daily_workouts;
-- truncate table diet_plans;