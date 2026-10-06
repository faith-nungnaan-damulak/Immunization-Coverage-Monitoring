SELECT r.region_name AS country, v.vaccine_name, c.coverage_pct
FROM coverage c
JOIN regions r  ON c.region_id = r.region_id
JOIN vaccines v ON c.vaccine_id = v.vaccine_id
WHERE c.year = 2025 AND c.coverage_pct < 80
ORDER BY c.coverage_pct ASC;