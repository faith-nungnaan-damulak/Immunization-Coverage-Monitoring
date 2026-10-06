# Immunization Coverage Monitoring Database

A relational database and Power BI dashboard that monitors routine vaccination coverage across six West and Central African countries from 2015 to 2025. The project answers a core monitoring and evaluation question: **where is coverage lowest, and where are children being lost between the first and third dose?**

![Dashboard](images/dashboard.png)

## Key findings (2025)

| Finding | Result |
|---|---|
| Lowest DTP3 coverage | **Nigeria, 62%**, though up 20 points from 42% in 2015 |
| Highest DTP1 to DTP3 dropout | **Chad, 17.4%** (86% start the series, 71% finish it) |
| Only country in decline since 2015 | **Benin**, down 5 points (74% to 69%) |
| Benchmark | **Ghana, 99%** for DTP3 |

**What this means:** the two weakest performers have different problems. Nigeria's dropout is 11.4%, but only 70% of children receive DTP1, so the main gap is **reaching children in the first place**. Chad reaches 86% with DTP1 but loses 17.4% before DTP3, so its gap is **keeping children in the schedule**. Different problems need different interventions.

## Data

- **Source:** WHO/UNICEF Estimates of National Immunization Coverage (WUENIC), 2025 revision. Available from the WHO Immunization Data Portal and UNICEF data pages.
- **Scope:** Nigeria, Ghana, Niger, Cameroon, Benin and Chad; 15 vaccines; 2015 to 2025.
- **Size:** 766 rows after filtering (`data/wuenic_clean.csv`).

| Column | Meaning |
|---|---|
| `iso3c` | Three-letter country code |
| `country` | Country name |
| `vaccine` | Vaccine code (for example `dtp1`, `dtp3`, `mcv1`) |
| `year` | Estimate year |
| `target_grp` | Target group the coverage is measured against |
| `coverage` | Estimated coverage (%) |

## Database design

Three tables plus a staging table used for loading:

```
regions (region_id, region_name, zone)
vaccines (vaccine_id, vaccine_name, target_disease)
coverage (coverage_id, region_id, vaccine_id, year, coverage_pct)
            |                |
            +-- FK regions   +-- FK vaccines
```

## How it was built

1. Downloaded the WUENIC coverage dataset and cleaned it in Excel (filtered to six countries and 2015 onward, removed unused columns, saved as CSV).
2. Created the database in **MySQL** and loaded the CSV into a staging table.
3. Populated the `regions`, `vaccines` and `coverage` tables from staging using SQL.
4. Wrote analysis queries using joins, aggregation, self-joins and window functions.
5. Exported a flat table to CSV and built the dashboard in **Power BI**.

## Analysis queries

All SQL is in [`sql/immunization_analysis.sql`](sql/immunization_analysis.sql):

1. DTP3 coverage by country, 2025
2. DTP1 to DTP3 dropout rate, 2025
3. DTP3 coverage trend, 2015 to 2025
4. Vaccines below 80% coverage, 2025
5. Change in DTP3 coverage, 2015 to 2025

Dropout rate formula: `(DTP1 coverage - DTP3 coverage) / DTP1 coverage x 100`

## Dashboard

The Power BI dashboard has interactive vaccine and year slicers, four KPI cards (lowest DTP3 coverage, benchmark, highest dropout, and Benin's change since 2015), a DTP3 coverage bar chart, a dropout bar chart and a DTP3 trend line chart.

## How to reproduce

1. Install MySQL Server and MySQL Workbench.
2. Open `sql/immunization_analysis.sql` and run section 1 (schema) and section 2 (staging table).
3. Import `data/wuenic_clean.csv` into `staging_wuenic` using the Table Data Import Wizard. Confirm 766 rows.
4. Run section 3 once to fill the three main tables. Confirm 6, 15 and 766 rows.
5. Run the analysis queries in section 4.
6. Run the export query in section 5, save the result as CSV, and load it into Power BI.

## Limitations

- WUENIC provides **national-level** estimates only, so this project compares countries, not states or districts.
- Six countries were selected for focus; the findings do not describe the whole region.
- Dropout is calculated from estimated coverage figures, not from individual child records.
- Coverage values are rounded to whole numbers in the source file.

## Next steps

- Add state-level coverage for Nigeria from the Demographic and Health Surveys (DHS) Program.
- Add zero-dose children as an indicator.
- Link to the facility monitoring and disease surveillance projects in this portfolio series.

## Tools

MySQL, MySQL Workbench, SQL, Microsoft Excel, Power BI

## Author

Faith Nungnaan Damulak
