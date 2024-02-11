DROP DATABASE IF EXISTS fitnessfusiondb;

CREATE DATABASE fitnessfusiondb;

USE fitnessfusiondb;

CREATE TABLE Exercise_Equipments(
    eq_id INT AUTO_INCREMENT,
    name VARCHAR(25),
    CONSTRAINT Exercise_Equipments_primary_key PRIMARY KEY (eq_id)
);

CREATE TABLE Exercise_type(
    -- PUSH PULL
    type_id INT AUTO_INCREMENT,
    type_name VARCHAR(4),
    CONSTRAINT exercise_type_Primary_key PRIMARY KEY (type_id)
);

CREATE TABLE Body_Domain(
    -- Body Parts
    dom_id INT AUTO_INCREMENT,
    name VARCHAR(10),
    CONSTRAINT exercise_category_types_Primary_key PRIMARY KEY (dom_id)
);

CREATE TABLE BodyParts(
    -- Sub Parts
    bp_id INT AUTO_INCREMENT,
    name VARCHAR(20),
    dom_id INT,
    CONSTRAINT exercise_category__Primary_key PRIMARY KEY (bp_id),
    CONSTRAINT exercise_category__foreign_key FOREIGN KEY (dom_id) REFERENCES Body_Domain(dom_id)
);

CREATE TABLE Exercises(
    e_id INT AUTO_INCREMENT,
    name VARCHAR(25),
    description VARCHAR(1024),
    image MEDIUMBLOB,
    bp_id INT,
    type_id INT,
    eq_id INT,
    CONSTRAINT exercises_primary_key PRIMARY KEY (e_id),
    CONSTRAINT exercises_foreign_keys FOREIGN KEY (bp_id) REFERENCES BodyParts(bp_id),
    FOREIGN KEY (type_id) REFERENCES Exercise_type(type_id),
    FOREIGN KEY (eq_id) REFERENCES Exercise_Equipments(eq_id)
);

CREATE TABLE Food_Items(
    f_id INT AUTO_INCREMENT,
    name VARCHAR(25),
    description VARCHAR(256),
    image MEDIUMBLOB,
    calories INT,
    fats INT,
    protein INT,
    carbohydrates INT,
    fibre INT,
    sugar INT,
    CONSTRAINT food_items_primary_key PRIMARY KEY (f_id)
);

CREATE TABLE User_types(
    t_id INT AUTO_INCREMENT,
    name VARCHAR(10),
    CONSTRAINT user_types_primary_key PRIMARY KEY (t_id)
);

CREATE TABLE User_authentication(
    username VARCHAR(50),
    user_id INT UNIQUE AUTO_INCREMENT, 
    password VARCHAR(128),
    user_type INT,
    CONSTRAINT user_authentication_primary_key PRIMARY KEY (username),
    CONSTRAINT user_authentication_foreign_key FOREIGN KEY (user_type) REFERENCES User_types(t_id)
);

CREATE TABLE User_info(
    user_id INT,
    name VARCHAR(50),
    gender CHAR,
    height FLOAT,
    weight FLOAT,
    date_of_birth DATE,
    email VARCHAR(100),
    contact VARCHAR(30),
    CONSTRAINT user_info_primary_key PRIMARY KEY (user_id),
    CONSTRAINT user_info_primary_key FOREIGN KEY (user_id) REFERENCES User_authentication(user_id)
);

CREATE TABLE Workout_Plans(
    w_id INT auto_increment,
    Creator INT,
    name VARCHAR(50),
    date_of_creation DATE,
    CONSTRAINT user_workouts_primary_key PRIMARY KEY (w_id), CONSTRAINT diet_plans_foreign_key FOREIGN KEY (Creator) REFERENCES User_authentication(user_id)
);

CREATE TABLE User_workouts(
    user_id INT,
    w_id INT,
    Enrollment_Date DATE,
    CONSTRAINT user_workouts_primary_key PRIMARY KEY (user_id, w_id),
    CONSTRAINT user_workouts_foreign_key FOREIGN KEY (user_id) REFERENCES User_authentication(user_id),
    FOREIGN KEY (w_id) REFERENCES Workout_Plans(w_id)
);

CREATE TABLE daily_workouts(
    w_id INT,
    e_id INT,
    day INT,
    sets INT,
    CONSTRAINT daily_workouts_foreign_key FOREIGN KEY (w_id) REFERENCES workout_plans(w_id),
    CONSTRAINT daily_workouts_foreign_key2 FOREIGN KEY (e_id) REFERENCES Exercises(e_id)
);

CREATE TABLE Diet_Plans(
    d_id INT auto_increment,
    Creator INT,
    date_of_creation DATE,
    name VARCHAR(50),
    CONSTRAINT diet_plans_primary_key PRIMARY KEY (d_id), 
    CONSTRAINT diet_plan_foreign_key FOREIGN KEY (Creator) REFERENCES User_authentication(user_id)
);

CREATE TABLE User_diets(
    user_id INT,
    d_id INT,
    Enrollment_Date DATE,
    CONSTRAINT user_diets_primary_key PRIMARY KEY (d_id),
    CONSTRAINT user_diets_foreign_key FOREIGN KEY (user_id) REFERENCES User_authentication(user_id),
    FOREIGN KEY (d_id) REFERENCES Diet_Plans(d_id)
);


CREATE TABLE Meals(
    f_id INT,
    quantity decimal,
    time time,
    d_id INT,
    CONSTRAINT meals_Foreign_KEy
    FOREIGN KEY (f_id) REFERENCES food_items(f_id),
    FOREIGN KEY (d_id) REFERENCES Diet_Plans(d_id)
);

CREATE TABLE Keywords(
    kw_id INT PRIMARY KEY auto_increment,
    name VARCHAR(20)
);

CREATE TABLE Workout_Keywords(
    w_id INT,
    kw_id INT,
    CONSTRAINT wk_foreign_keys
    FOREIGN KEY (w_id) REFERENCES Workout_Plans(w_id),
    FOREIGN KEY (kw_id) REFERENCES Keywords(kw_id)
);

CREATE TABLE Diet_Keywords(
    d_id INT,
    kw_id INT,
    CONSTRAINT DK_foreign_keys
    FOREIGN KEY (d_id) REFERENCES Diet_Plans(d_id),
    CONSTRAINT DK_foreign_keys2    
    FOREIGN KEY (kw_id) REFERENCES Keywords(kw_id)
);

CREATE TABLE feedback(
    user_id INT,
    description VARCHAR(1024),
    upload_time DATE,
    CONSTRAINT feedback_foreign_keys FOREIGN KEY (user_id) REFERENCES User_authentication(user_id)
);


CREATE TABLE Requests(
	r_id INT Primary key auto_increment,
    username VARCHAR(50),
    password VARCHAR(128),
    name VARCHAR(50),
    gender CHAR,
    height FLOAT,
    weight FLOAT,
    date_of_birth DATE,
    email VARCHAR(100),
    contact VARCHAR(30)
);