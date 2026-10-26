Annual trends in selected water-quality indicators

Purpose:
Compare annual average, minimum, maximum and measurement count
for selected water-quality parameters from 2021 to 2025.

Below-detection treatment:
Values reported as <x were replaced with x/2 in the cleaned field.

Important:
Results are descriptive trends and are not official regulatory
water-quality classifications.
*/

overall annual trends
SELECT
    sample_year,
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
    parameter_name,
    unit
ORDER BY
    parameter_name,
    sample_year;