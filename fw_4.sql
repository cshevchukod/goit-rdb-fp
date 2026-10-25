USE pandemic;
SELECT
    Year,
    MAKEDATE(Year, 1) AS first_january,
    CURDATE() AS today_date,
    TIMESTAMPDIFF(
        YEAR,
        MAKEDATE(Year, 1),
        CURDATE()
    ) AS year_difference
FROM infectious_cases_normalized;