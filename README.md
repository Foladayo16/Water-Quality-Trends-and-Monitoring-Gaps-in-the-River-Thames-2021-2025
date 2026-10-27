 # Water Quality Trends and Monitoring Gaps in the River Thames, 2021–2025

# Project Overview

This portfolio project examines water-quality conditions across selected stretches of the River Thames using monitoring data from the Environment Agency.

The analysis investigates how key water-quality indicators changed over time and differed between river stretches. It focuses on ammoniacal nitrogen, reactive orthophosphate, dissolved oxygen saturation and pH, with water temperature used as a supporting example of incomplete seasonal monitoring.

The project demonstrates an end-to-end environmental data-analysis workflow using Excel, SQL and Looker Studio. This includes data preparation, exploratory analysis, temporal and geographical comparisons, anomaly investigation and the communication of reproducible findings.

The analysis is intended as a descriptive screening exercise and does not represent an official regulatory water-quality classification.


# Project Aim
To analyse changes in selected water-quality indicators across four River Thames stretches between 2021 and 2025, identify unusual results and assess how monitoring limitations affect interpretation.

# Project Objectives
Prepare the monitoring records for analysis by cleaning measurement values and retaining detection-limit information.
Measure overall annual trends in selected water-quality indicators.
Compare annual results across the four river stretches.
Investigate unusual measurements that may influence annual averages.
Evaluate how missing periods, unequal record counts and below-detection results affect interpretation.
Communicate the results through Excel, SQL and Looker Studio.

# Project Questions
How did the selected water-quality indicators change between 2021 and 2025?
How did annual trends differ between the four river stretches?
Which parameters showed the greatest temporal or geographical variation?
Which parameter, year and river-stretch combinations contained unusual results requiring closer investigation?
How did detection limits, missing monitoring periods and unequal record counts affect the reliability of comparisons?

## Study Area

The analysis covers four sections of the River Thames:
Wallingford to Caversham: upstream
Reading to Cookham: upper-middle
Cookham to Egham: lower-middle
Egham to Teddington:  downstream

This structure allows water-quality conditions to be compared along the selected upstream-to-downstream pathway.

## Data Source

The project uses publicly available water-quality monitoring data from the Environment Agency's Water Quality Explorer.

The source data include observations collected at monitoring sites along selected sections of the River Thames. Each observation may contain information about the sampling location, sample date, water-quality parameter, measured value and unit of measurement.

**Publisher:** Environment Agency
**Source:** [Water Quality Explorer](https://www.data.gov.uk/dataset/583e771f-1af6-4934-b8f0-28f1d1ddd48c/water-quality-explorer)
**Data accessed:** 31 July 2026
**Geographical coverage:** Selected River Thames monitoring locations between     Wallingford and Teddington
**Analysis period:** 2021–2025
**Sample material:** River or running surface water
**Raw data location:** `data/raw/`
**Processed data location:** `data/processed/`

The original source files are preserved unchanged in the local `data/raw/` directory. The public repository does not include all raw files because of their volume and to avoid unnecessary duplication of the source data.


## Parameters Analysed
```text
pH
Temperature of Water
Oxygen, Dissolved, % Saturation
Orthophosphate, reactive as P
Ammoniacal nitrogen as N
```

## Analysis Approach

The exploratory analysis compares average annual measurements across the four river sections from 2021 to 2025. Each parameter is analysed separately and only records with matching measurement units are combined.

Annual averages are interpreted alongside sampling coverage because the number and timing of observations differ between river sections and years. The analysis identifies patterns for further investigation and does not represent a formal regulatory water-quality classification.
Further details are provided in the docs/analysis_methodology.md.

## Preliminary Findings

pH: Annual averages remained relatively stable, with only minor variation between years and river sections.

Dissolved oxygen saturation: Annual averages remained relatively high overall, although Egham to Teddington recorded a temporary reduction in 2023 before recovering.

Orthophosphate: Concentrations generally declined across much of the study area, although increases in some sections during 2025 indicate continued variability.
Detailed findings are documented in docs/findings.md.

Ammoniacal nitrogen: Annual averages declined across the monitored sections and generally stabilised at lower concentrations during the later study years.

Detailed findings are documented in [Exploratory Analysis Findings](docs/findings.md).

# Key Findings

Annual ammoniacal nitrogen was highest in 2021, influenced by a maximum result of 6.90 mg/L. 
Reactive orthophosphate declined through 2024 before increasing in 2025.
Dissolved oxygen saturation remained comparatively stable.

Cookham–Egham recorded a median ammoniacal nitrogen concentration of 0.034 mg/L in 2021, while the maximum reached 6.90 mg/L. Of the 80 recorded measurements, 62.5% were below detection limits. 
A sensitivity analysis reduced the mean from 0.180 mg/L to 0.095 mg/L when the 6.90 mg/L result was excluded. This difference of 0.085 mg/L shows that the maximum measurement increased the reported mean by approximately 47%. The result was retained in the dataset because the analysis measures its influence rather than assuming it was erroneous.

# Dashboard
The two-page interactive dashboard was developed in Looker Studio to communicate the main findings and allow users to explore annual and geographical patterns.

# Page 1: Executive Summary
The executive-summary page presents the project objective, key findings, conclusions and monitoring recommendations.

!(Executive summary)(visuals/data-quality-report.xlsx/execucutive_summary.png)

# Page 2: Interactive Analysis
The interactive-analysis page allows users to filter the results by year, river stretch and parameter. It includes annual trends, river-stretch comparisons, measurement counts and monitoring-coverage information.
!(Interactive Analysis)(visuals/data-quality-report.xlsx/interactive_analysis.png)

## Repository Structure
```text
Water-Quality-and-Risk-Assessment/
├── README.md              # Main project documentation
├── .gitignore             # Files excluded from version control
├── data/
│   ├── raw/               # Original source files, not publicly uploaded
│   └── processed/         # Cleaned and analysis-ready data
├── analysis/              # Excel, SQL or other analytical work
├── docs/                  # Methodology, data dictionary and limitations
├── visuals/               # Exported charts, maps and figures
└── dashboard/             # Dashboard files, screenshots and supporting notes
```

## Documentation

Supporting project documentation

## Supporting Project Documentation

[Data Dictionary](docs/data_dictionary.md)
[Analysis Methodology](docs/analysis_methodology.md)
[Exploratory Analysis Findings](docs/findings.md)

## Data Preparation and Cleaning

The original files were combined into a single analysis-ready dataset covering the four selected River Thames sections and the 2021–2025 analysis period.

The following preparation steps were completed:

- Preserved the original downloaded files separately in `data/raw/`.
- Combined records from different river sections and years.
- Standardised the main column names across the source files.
- Converted date fields into consistent date formats.
- Created `sample_year` to support annual comparisons.
- Retained `parameter_code` as a categorical identifier.
- Checked measurement units across parameters and source files.
- Created a numeric `measurement_value_cleaned` field for analysis.
- Created detection-limit flags to distinguish censored measurements from ordinary numeric values.
- Restricted the main analysis to 2021–2025 because the available 2020 records were incomplete.

The processed dataset retains source-identification, location, sampling, parameter, measurement and unit fields to support traceability.

### Handling Detection-Limit Values

Some source measurements contain qualifiers such as `<` or `>`, rather than ordinary numeric values. These indicate that the reported concentration was below or above a stated detection or reporting limit.

To preserve this information:

- The original reported value was retained in `measurement_value`.
- A numeric analysis value was stored in `measurement_value_cleaned`.
- `below_detection_limit` identifies values reported below a stated limit.
- `above_detection_limit` identifies values reported above a stated limit.

Detection-limit records were therefore not treated automatically as missing values. They were retained with separate flags so that their treatment remains visible during analysis.

### Data Quality Review

Before interpreting water-quality trends, the combined dataset was reviewed for:

* Missing values and duplicate observations
* Invalid or inconsistent dates
* Non-numeric measurement values
* Results below detection limits or above analytical ranges
* Inconsistent units within parameters
* Unexpected or potentially extreme values
* Uneven monitoring coverage across river stretches and years
* Differences in parameter availability and sampling frequency

Results reported below detection limits were retained using half the stated detection limit. Results above analytical ranges were retained as flagged boundary values.

Potentially extreme measurements were not automatically treated as errors. Unusual records were investigated because they may represent either data-quality issues or genuine environmental events.

## Limitations

* Sampling frequency differs between river sections and years.
* Some months and location-year combinations have no available observations.
* Parameter availability is not consistent across the full dataset.
* Annual averages may conceal seasonal variation and individual extreme measurements.
* Detection-limit substitutions can influence calculated averages.
* Geographical differences may reflect monitoring coverage as well as environmental variation.
* The analysis identifies associations and patterns but does not establish their causes.
* The findings do not represent a formal regulatory water-quality classification.

# Monitoring Coverage and Detection Limits
Monitoring coverage varied by parameter, river stretch and year. For example, Cookham–Egham ammoniacal nitrogen records contained no observations for August, September or October 2022. The same parameter had observations in only seven months during 2024.

These gaps mean that some annual summaries may not represent complete seasonal conditions. Months without observations were treated as coverage gaps, not as evidence that scheduled sampling was missed.

Results reported below analytical detection limits were retained using half the stated detection limit. Results reported above the analytical range were also retained as flagged boundary values rather than treated as exact measurements.

## Recommendations

Continue monitoring orthophosphate where concentrations increased during 2025.
Investigate unusual annual results using monthly and site-level observations.
Compare annual averages with observation counts before drawing conclusions.
Expand the analysis to include seasonal patterns where data coverage is sufficient.
Document and validate all thresholds before creating the proposed risk score.
Retain detection-limit flags in any future dashboard or statistical analysis.
Prioritise transparent reporting of missing months and uneven sampling coverage.

## Data Attribution
Source: Environment Agency, Water Quality Explorer, accessed 31 July 2026.

© Environment Agency copyright and/or database right 2025. Used under the Open Government Licence.

### Source Data Considerations

The Water Quality Explorer is a continuously maintained source, so records may be updated or corrected after the project data are downloaded. Sampling frequency and parameter availability may also differ between monitoring locations and years.

For reproducibility, this project records the data-access date and preserves the downloaded raw files unchanged. The analysis reflects the version of the source data available when the project files were collected.

/*
Conclusion:
The 6.90 mg/L result substantially influenced the Cookham-Egham
2021 mean. Excluding it in a sensitivity test reduced the mean
from 0.180 mg/L to 0.095 mg/L, a difference of 0.085 mg/L.

The observation remains in the dataset because there is insufficient
evidence to classify it as an error.

Monitoring coverage varied across parameter, year and river stretch.
Some annual summaries were based on partial monthly coverage.

Missing months indicate no matching observations in the dataset.
They do not establish that scheduled sampling was missed.

Below- and above-detection-limit flags were retained to support
transparent interpretation of boundary values.
*/