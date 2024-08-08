-- Change the default delimiter to allow defining the procedure
DELIMITER //

-- Start creating the stored procedure
CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    -- Declare variables to store the total weighted score and total weight for each user
    DECLARE user_id INT;
    DECLARE done INT DEFAULT 0;
    DECLARE total_weighted_score FLOAT;
    DECLARE total_weight INT;
    
    -- Declare a cursor to iterate over each user
    DECLARE user_cursor CURSOR FOR
    SELECT id FROM users;
    
    -- Declare a handler to set done flag when no more rows are found
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    -- Open the cursor
    OPEN user_cursor;
    
    -- Loop through each user
    read_loop: LOOP
        -- Fetch the next user ID
        FETCH user_cursor INTO user_id;
        
        -- Exit the loop if no more users
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Calculate the total weighted score for the current user
        SELECT SUM(c.score * p.weight) INTO total_weighted_score
        FROM corrections c
        JOIN projects p ON c.project_id = p.id
        WHERE c.user_id = user_id;
        
        -- Calculate the total weight for the current user's projects
        SELECT SUM(p.weight) INTO total_weight
        FROM corrections c
        JOIN projects p ON c.project_id = p.id
        WHERE c.user_id = user_id;
        
        -- Update the user's average_score with the calculated weighted average
        UPDATE users
        SET average_score = IF(total_weight > 0, total_weighted_score / total_weight, 0)
        WHERE id = user_id;
    END LOOP;
    
    -- Close the cursor
    CLOSE user_cursor;
END//

-- Reset the delimiter back to the default
DELIMITER ;
