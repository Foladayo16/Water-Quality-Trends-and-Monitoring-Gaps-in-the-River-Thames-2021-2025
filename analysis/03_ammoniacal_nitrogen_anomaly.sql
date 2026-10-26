
Ammoniacal_nitrogen_anomaly.sql

# Identify the measurements driving the anomaly

SELECT
    river_stretch,
    site_id,
    site_name,
    sample_date,
    measurement_value AS original_measurement,
    measurement_value_cleaned AS cleaned_measurement,
    below_detection_limit,
    unit
FROM `water-quality-510014.water_quality.Risk_assessment`
WHERE parameter_name = 'Ammoniacal Nitrogen as N'
  AND sample_year = 2021
  AND measurement_value_cleaned IS NOT NULL
ORDER BY measurement_value_cleaned DESC
LIMIT 10;

# Compare the Cookham-Egham 2021 mean before and after excluding the 6.90 mg/L maximum result

SELECT
    river_stretch,
    COUNT(*) AS measurement_count,
    ROUND(AVG(measurement_value_cleaned), 3) AS mean_with_maximum,
    ROUND(
        AVG(
            CASE
                WHEN measurement_value_cleaned < 6.9
                THEN measurement_value_cleaned
            END
        ),
        3
    ) AS mean_without_6_9,
    ROUND(
        AVG(measurement_value_cleaned)
        - AVG(
            CASE
                WHEN measurement_value_cleaned < 6.9
                THEN measurement_value_cleaned
            END), 3
                    ) AS difference_caused_by_maximum
FROM `water-quality-510014.water_quality.Risk_assessment`
WHERE parameter_name = 'Ammoniacal Nitrogen as N'
  AND river_stretch = 'Cookham-Egham'
  AND sample_year = 2021
  AND measurement_value_cleaned IS NOT NULL
GROUP BY river_stretch;