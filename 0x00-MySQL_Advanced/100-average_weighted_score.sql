-- Change the default delimiter to allow defining the procedure
DELIMITER //

CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
	    DECLARE total_weighted_score FLOAT;
	    DECLARE total_weight INT;
	    
	    -- Calculate the total weighted score for the user
    SELECT SUM(c.score * p.weight) INTO total_weighted_score
    FROM corrections c
    JOIN projects p ON c.project_id = p.id
    WHERE c.user_id = user_id;
    
    -- Calculate the total weight for the user's projects
    SELECT SUM(p.weight) INTO total_weight
    FROM corrections c
    JOIN projects p ON c.project_id = p.id
    WHERE c.user_id = user_id;
    
    -- Update the user's average_score with the calculated weighted average
    UPDATE users
    SET average_score = IF(total_weight > 0, total_weighted_score / total_weight, 0)
    WHERE id = user_id;
END//

DELIMITER ;
