SELECT r.region_name AS country, c.year, c.coverage_pct
FROM coverage c
JOIN regions r  ON c.region_id = r.region_id
JOIN vaccines v ON c.vaccine_id = v.vaccine_id
WHERE v.vaccine_name = 'dtp3' AND c.year = 2025
ORDER BY c.coverage_pct ASC;