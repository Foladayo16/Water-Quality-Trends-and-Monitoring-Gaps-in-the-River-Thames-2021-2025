 Data Quality and Detection Limit

# Detection limit summary

/* Measure the proportion of results reported below detection limits
for each selected parameter, year and river stretch.

Below-detection treatment: Values reported as <x were replaced with x/2 in
measurement_value_cleaned.
*/ 

SELECT
    sample_year,
    river_stretch,
    parameter_name,
    unit,
    COUNT(measurement_value_cleaned) AS measurement_count,
    COUNTIF(below_detection_limit = 1) AS below_detection_count,
    ROUND(
        100 * SAFE_DIVIDE(
            COUNTIF(below_detection_limit = 1),
            COUNT(measurement_value_cleaned)
        ),
        2
    ) AS below_detection_percentage
FROM `water-quality-510014.water_quality.Risk_assessment`
WHERE parameter_name IN (
    'Ammoniacal Nitrogen as N',
    'Orthophosphate, reactive as P',
    'Oxygen, Dissolved, % Saturation',
    'pH' )
  AND measurement_value_cleaned IS NOT NULL
GROUP BY
    sample_year,
    river_stretch,
    parameter_name,
    unit
ORDER BY
    below_detection_percentage DESC,
    parameter_name,
    sample_year,
    river_stretch;

# Monthly monitoring coverage

    /* Count the number of distinct monitored months for every parameter, year and river stretch.
This identifies annual summaries based on incomplete seasonal coverage.
*/

SELECT
    sample_year,
    river_stretch,
    parameter_name,
    COUNT(DISTINCT EXTRACT(MONTH FROM sample_date)) AS months_monitored,
    12 - COUNT(DISTINCT EXTRACT(MONTH FROM sample_date)) AS months_missing,
    COUNT(measurement_value_cleaned) AS measurement_count
FROM `water-quality-510014.water_quality.Risk_assessment`
WHERE parameter_name IN (
    'Ammoniacal Nitrogen as N',
    'Orthophosphate, reactive as P',
    'Oxygen, Dissolved, % Saturation',
    'pH',
    'Temperature of Water'
)
  AND sample_date IS NOT NULL
  AND measurement_value_cleaned IS NOT NULL
GROUP BY
    sample_year,
    river_stretch,
    parameter_name
ORDER BY
    months_monitored,
    parameter_name,
    sample_year,
    river_stretch;