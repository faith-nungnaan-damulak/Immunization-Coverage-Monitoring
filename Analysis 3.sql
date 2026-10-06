SELECT r.region_name AS country,
       d1.coverage_pct AS dtp1,
       d3.coverage_pct AS dtp3,
       ROUND((d1.coverage_pct - d3.coverage_pct) / d1.coverage_pct * 100, 1) AS dropout_pct
FROM coverage d1
JOIN coverage d3 ON d1.region_id = d3.region_id AND d1.year = d3.year
JOIN regions r   ON r.region_id = d1.region_id
JOIN vaccines v1 ON d1.vaccine_id = v1.vaccine_id AND v1.vaccine_name = 'dtp1'
JOIN vaccines v3 ON d3.vaccine_id = v3.vaccine_id AND v3.vaccine_name = 'dtp3'
WHERE d1.year = 2025
ORDER BY dropout_pct DESC;