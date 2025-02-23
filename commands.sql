-- Task #1

1.1 CREATE SCHEMA pandemic;

1.2 USE pandemic;

1.3 ImportTable

1.4 SELECT * FROM infectious_cases;

1.5  DROP TABLE IF EXISTS entity;

CREATE TABLE IF NOT EXISTS entity
(
id INT PRIMARY KEY auto_increment,
title TEXT,
code TEXT
);

-- Task #2

2.1
CREATE TABLE IF NOT EXISTS entities
(
id INT PRIMARY KEY auto_increment,
entity TEXT,
code TEXT
);

ALTER TABLE infectious_cases ADD entity_id INT DEFAULT 0;

INSERT INTO entities (entity, code) SELECT DISTINCT Entity, Code FROM infectious_cases;

SELECT * FROM entities;

2.2
UPDATE infectious_cases AS ic
LEFT JOIN entities AS e ON ic.Entity=e.entity 
SET ic.entity_id = e.id;

SELECT * FROM infectious_cases;

ALTER TABLE infectious_cases DROP COLUMN Entity;

ALTER TABLE infectious_cases DROP COLUMN Code;

-- Task #3

SELECT entity_id,
FLOOR(AVG(Number_rabies)) AS avg, 
FLOOR(MAX(Number_rabies)) AS max, 
FLOOR(MIN(Number_rabies)) AS min, 
FLOOR(SUM(Number_rabies)) as total 
FROM infectious_cases 
WHERE Number_rabies != ''
GROUP BY entity_id 
ORDER BY avg DESC
LIMIT 10
;


-- Task #4

SELECT 
Year, 
MAKEDATE(Year, 1) AS Date, 
STR_TO_DATE(NOW(),'%Y-%m-%d') AS Today, 
TIMESTAMPDIFF(YEAR,MAKEDATE(Year, 1), NOW()) AS YearsDiff
FROM infectious_cases
;


-- Task #5

5.1
DROP FUNCTION IF EXISTS CalculateYearsDiff;

DELIMITER //

CREATE FUNCTION CalculateYearsDiff(year TEXT)
RETURNS INT
DETERMINISTIC 
NO SQL
BEGIN
    DECLARE result INT;
    SET result = TIMESTAMPDIFF(YEAR,MAKEDATE(year, 1), NOW());
    RETURN result;
END //

DELIMITER ;

5.2
SELECT 
Year, 
MAKEDATE(Year, 1) AS Date, 
STR_TO_DATE(NOW(),'%Y-%m-%d') AS Today, 
CalculateYearsDiff(Year) AS YearsDiff
FROM infectious_cases
;




