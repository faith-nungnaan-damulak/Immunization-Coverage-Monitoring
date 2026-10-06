USE immunization_db;

SELECT r.region_name AS country,
       r.zone,
       v.vaccine_name AS vaccine,
       v.target_disease,
       c.year,
       c.coverage_pct
FROM coverage c
JOIN regions r  ON c.region_id = r.region_id
JOIN vaccines v ON c.vaccine_id = v.vaccine_id;