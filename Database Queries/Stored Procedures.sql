DELIMITER //

CREATE PROCEDURE Authenticate(IN usern VARCHAR(50),IN pass VARCHAR(128))
BEGIN
    SELECT user_id FROM user_authentication WHERE username = usern AND password = pass;
END //

DELIMITER ;

call Authenticate('mok','pass');