USE pandemic;
SELECT
    e.Entity,
    e.Code,
    AVG(CAST(ic.Number_rabies AS DECIMAL(15, 2))) AS avg_rabies,
    MIN(CAST(ic.Number_rabies AS DECIMAL(15, 2))) AS min_rabies,
    MAX(CAST(ic.Number_rabies AS DECIMAL(15, 2))) AS max_rabies,
    SUM(CAST(ic.Number_rabies AS DECIMAL(15, 2))) AS sum_rabies
FROM infectious_cases_normalized AS ic
JOIN entities AS e
    ON ic.entity_id = e.id
WHERE ic.Number_rabies IS NOT NULL
    AND ic.Number_rabies != ''
GROUP BY e.id, e.Entity, e.Code
ORDER BY avg_rabies DESC
LIMIT 10;