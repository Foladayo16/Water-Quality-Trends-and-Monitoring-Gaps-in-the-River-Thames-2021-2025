

Annual trends by river stretch

    SELECT
    sample_year,
    river_stretch,
    parameter_name,
    unit,
    ROUND(AVG(measurement_value_cleaned), 3) AS average_value,
    ROUND(MIN(measurement_value_cleaned), 3) AS minimum_value,
    ROUND(MAX(measurement_value_cleaned), 3) AS maximum_value,
    COUNT(measurement_value_cleaned) AS measurement_count
FROM `water-quality-510014.water_quality.Risk_assessment`
WHERE parameter_name IN (
    'Ammoniacal Nitrogen as N',
    'Orthophosphate, reactive as P',
    'Oxygen, Dissolved, % Saturation',
    'pH'
)
AND measurement_value_cleaned IS NOT NULL
GROUP BY
    sample_year,
    river_stretch,
    parameter_name,
    unit
ORDER BY
    parameter_name,
    river_stretch,
    sample_year;
