SELECT r.region_name AS country,
       a.coverage_pct AS cov_2015,
       b.coverage_pct AS cov_2025,
       b.coverage_pct - a.coverage_pct AS change_pts
FROM coverage a
JOIN coverage b ON a.region_id = b.region_id AND a.vaccine_id = b.vaccine_id
JOIN regions r  ON r.region_id = a.region_id
JOIN vaccines v ON v.vaccine_id = a.vaccine_id
WHERE v.vaccine_name = 'dtp3' AND a.year = 2015 AND b.year = 2025
ORDER BY change_pts ASC;