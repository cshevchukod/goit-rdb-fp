USE pandemic;
DELIMITER //
CREATE FUNCTION year_difference(input_year INT)
RETURNS INT
NOT DETERMINISTIC
NO SQL
BEGIN
    RETURN TIMESTAMPDIFF(
        YEAR,
        MAKEDATE(input_year, 1),
        CURDATE()
    );
END //
DELIMITER ;
SELECT
    Year,
    MAKEDATE(Year, 1) AS first_january,
    CURDATE() AS today_date,
    year_difference(Year) AS year_difference
FROM infectious_cases_normalized
LIMIT 10;