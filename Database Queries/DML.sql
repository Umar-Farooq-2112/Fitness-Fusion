INSERT INTO Exercise_type VALUES
(1, "Push"),
(2, "Pull");


INSERT INTO Body_Domain VALUES
(1, "Chest"),
(2, "Back"),
(3, "Shoulder"),
(4, "Abs"),
(5, "Arms"),
(6, "Legs");

INSERT INTO BodyParts VALUES
(1, "Upper Chest",1),
(2, "Middle Chest",1),
(3, "Lower Chest",1),
(4, "Inner Chest",1),
(5, "Bicep",5),
(6, "Tricep",5),
(7, "ForeArms",5),
(8, "Upper Abs",4),
(9, "Lower Abs",4),
(10, "Obliques",4),
(11, "Upper Back",2),
(12, "Lower Back",2),
(13, "Lats",2),
(14, "Front Delts",3),
(15, "Lateral Delts",3),
(16, "Rear Delts",3),
(17, "Traps",3),
(18, "Calves",6),
(19, "Quads",6),
(20, "Glutes",6),
(21, "Hamstrings",6),
(22, "Hybrid" , 1),
(23, "Hybrid" , 2),
(24, "Hybrid" , 3),
(25, "Hybrid" , 4),
(26, "Hybrid" , 5);

INSERT INTO Exercise_Equipments VALUES
(1, "Bodyweight"),
(2, "Dumbbell"),
(3, "Barbell"),
(4, "Machine");


INSERT INTO User_types VALUES
(1, "Admin"),
(2, "Trainer"),
(3, "Trainee");


INSERT INTO User_authentication VALUES
('admin', 1 , 'adminpassword', 1),
('mok', 2, 'pass', 2),
('temp', 3 , 'pass', 3);

INSERT INTO keywords VALUES
(1,"Fat loss"),
(2,"Muscle Gain"),
(3,"Bulking"),
(4,"Shredding"),
(5,"Weight Loss");


INSERT INTO User_info VALUES
(1,'Admin','M',177.8,52,'2003-12-21','Admin@gmail.com','987654321'),
(2,'Muhammad Owais Khan','M',175.8,60,'2003-08-14','mok@gmail.com','123456789'),
(3,'temp','M',170.8,60,'2004-11-23','','000011112222');


INSERT INTO Requests VALUES
(1,'requserName','1234','reqname','M',175.5,75,'2000-01-01','req@gmail.com','1234');