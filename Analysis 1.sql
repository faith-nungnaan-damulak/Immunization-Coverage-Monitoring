USE immunization_db;

-- 1. Regions (the 6 countries)
INSERT INTO regions (region_id, region_name, zone)
SELECT ROW_NUMBER() OVER (ORDER BY country), country,
  CASE WHEN country IN ('Cameroon','Chad') THEN 'Central Africa'
       ELSE 'West Africa' END
FROM (SELECT DISTINCT country FROM staging_wuenic) c;

-- 2. Vaccines
INSERT INTO vaccines (vaccine_id, vaccine_name, target_disease)
SELECT ROW_NUMBER() OVER (ORDER BY vaccine), vaccine,
  CASE vaccine
    WHEN 'bcg'   THEN 'Tuberculosis'
    WHEN 'dtp1'  THEN 'Diphtheria, tetanus, pertussis'
    WHEN 'dtp3'  THEN 'Diphtheria, tetanus, pertussis'
    WHEN 'hepb3' THEN 'Hepatitis B'
    WHEN 'hepbb' THEN 'Hepatitis B (birth dose)'
    WHEN 'hib3'  THEN 'Haemophilus influenzae type b'
    WHEN 'ipv1'  THEN 'Polio (inactivated)'
    WHEN 'ipvc'  THEN 'Polio (inactivated)'
    WHEN 'mcv1'  THEN 'Measles'
    WHEN 'mcv2'  THEN 'Measles'
    WHEN 'menga' THEN 'Meningitis A'
    WHEN 'pcvc'  THEN 'Pneumococcal disease'
    WHEN 'rcv1'  THEN 'Rubella'
    WHEN 'rotac' THEN 'Rotavirus'
    WHEN 'yfv'   THEN 'Yellow fever'
  END
FROM (SELECT DISTINCT vaccine FROM staging_wuenic) v;

-- 3. Coverage (links everything together)
INSERT INTO coverage (coverage_id, region_id, vaccine_id, year, coverage_pct)
SELECT ROW_NUMBER() OVER (ORDER BY s.country, s.vaccine, s.year),
       r.region_id, v.vaccine_id, s.year, s.coverage
FROM staging_wuenic s
JOIN regions r  ON r.region_name  = s.country
JOIN vaccines v ON v.vaccine_name = s.vaccine;
SELECT COUNT(*) FROM regions;
SELECT COUNT(*) FROM vaccines;
SELECT COUNT(*) FROM coverage;