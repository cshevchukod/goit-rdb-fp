USE pandemic;
-- Check unique Entity and Code combinations
SELECT COUNT(*) AS unique_entities
FROM (
    SELECT DISTINCT Entity, Code
    FROM infectious_cases
) AS unique_data;
-- Create entities table
CREATE TABLE entities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Entity VARCHAR(255),
    Code VARCHAR(10)
);
-- Insert unique Entity and Code combinations
INSERT INTO entities (Entity, Code)
SELECT DISTINCT Entity, Code
FROM infectious_cases;
-- Check entities count
SELECT COUNT(*) AS total_entities
FROM entities;
-- Create normalized infectious cases table
CREATE TABLE infectious_cases_normalized (
    id INT AUTO_INCREMENT PRIMARY KEY,
    entity_id INT,
    Year INT,
    Number_yaws TEXT,
    polio_cases INT,
    cases_guinea_worm INT,
    Number_rabies TEXT,
    Number_malaria TEXT,
    Number_hiv TEXT,
    Number_tuberculosis TEXT,
    Number_smallpox TEXT,
    Number_cholera_cases TEXT,
    FOREIGN KEY (entity_id) REFERENCES entities(id)
);
-- Insert data into normalized table
INSERT INTO infectious_cases_normalized (
    entity_id,
    Year,
    Number_yaws,
    polio_cases,
    cases_guinea_worm,
    Number_rabies,
    Number_malaria,
    Number_hiv,
    Number_tuberculosis,
    Number_smallpox,
    Number_cholera_cases
)
SELECT
    e.id,
    ic.Year,
    ic.Number_yaws,
    ic.polio_cases,
    ic.cases_guinea_worm,
    ic.Number_rabies,
    ic.Number_malaria,
    ic.Number_hiv,
    ic.Number_tuberculosis,
    ic.Number_smallpox,
    ic.Number_cholera_cases
FROM infectious_cases AS ic
JOIN entities AS e
    ON ic.Entity = e.Entity
    AND ic.Code <=> e.Code;
-- Verify record counts
SELECT
    (SELECT COUNT(*) FROM infectious_cases) AS original_records,
    (SELECT COUNT(*) FROM infectious_cases_normalized) AS normalized_records,
    (SELECT COUNT(*) FROM entities) AS unique_entities;
-- Verify normalized data
SELECT
    e.Entity,
    e.Code,
    ic.Year,
    ic.polio_cases,
    ic.Number_rabies
FROM infectious_cases_normalized AS ic
JOIN entities AS e
    ON ic.entity_id = e.id
LIMIT 10;