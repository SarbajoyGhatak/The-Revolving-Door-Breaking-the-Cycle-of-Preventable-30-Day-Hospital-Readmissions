/*
CREATE TABLE public.hrrp_clean AS
WITH standardized AS (
    SELECT
        NULLIF(TRIM("Facility Name"), '') AS facility_name,
        NULLIF(UPPER(TRIM("Facility ID")), '') AS facility_id,
        NULLIF(UPPER(TRIM("State")), '') AS state,
        NULLIF(TRIM("Measure Name"), '') AS measure_name,
        NULLIF(TRIM("Number of Discharges"), '') AS discharges_raw,
        NULLIF(TRIM("Footnote"), '') AS footnote,
        NULLIF(TRIM("Excess Readmission Ratio"), '') AS err_raw,
        NULLIF(TRIM("Predicted Readmission Rate"), '') AS predicted_raw,
        NULLIF(TRIM("Expected Readmission Rate"), '') AS expected_raw,
        NULLIF(TRIM("Number of Readmissions"), '') AS readmissions_raw,
        NULLIF(TRIM("Start Date"), '') AS start_raw,
        NULLIF(TRIM("End Date"), '') AS end_raw
    FROM public.hrrp_raw
),
normalized AS (
    SELECT
        NULLIF(REGEXP_REPLACE(facility_name, '\s+', ' ', 'g'), '') AS facility_name,
        facility_id,
        state,
        measure_name,
        CASE WHEN UPPER(discharges_raw) IN
            ('N/A', 'NA', 'NOT AVAILABLE', 'NULL', '')
            THEN NULL ELSE discharges_raw END AS discharges_raw,
        footnote,
        CASE WHEN UPPER(err_raw) IN
            ('N/A', 'NA', 'NOT AVAILABLE', 'NULL', '')
            THEN NULL ELSE err_raw END AS err_raw,
        CASE WHEN UPPER(predicted_raw) IN
            ('N/A', 'NA', 'NOT AVAILABLE', 'NULL', '')
            THEN NULL ELSE predicted_raw END AS predicted_raw,
        CASE WHEN UPPER(expected_raw) IN
            ('N/A', 'NA', 'NOT AVAILABLE', 'NULL', '')
            THEN NULL ELSE expected_raw END AS expected_raw,
        CASE WHEN UPPER(readmissions_raw) IN
            ('N/A', 'NA', 'NOT AVAILABLE', 'NULL', '')
            THEN NULL ELSE readmissions_raw END AS readmissions_raw,
        start_raw,
        end_raw
    FROM standardized
),
typed AS (
    SELECT
        facility_name,
        facility_id,
        state,
        measure_name,

        CASE WHEN discharges_raw ~ '^[0-9,]+$'
            THEN REPLACE(discharges_raw, ',', '')::INTEGER
        END AS number_of_discharges,

        footnote,

        CASE WHEN err_raw ~ '^[0-9]+(\.[0-9]+)?$'
            THEN err_raw::NUMERIC(12,6)
        END AS excess_readmission_ratio,

        CASE WHEN predicted_raw ~ '^[0-9]+(\.[0-9]+)?%?$'
            THEN REPLACE(predicted_raw, '%', '')::NUMERIC(12,6)
        END AS predicted_readmission_rate,

        CASE WHEN expected_raw ~ '^[0-9]+(\.[0-9]+)?%?$'
            THEN REPLACE(expected_raw, '%', '')::NUMERIC(12,6)
        END AS expected_readmission_rate,

        CASE WHEN readmissions_raw ~ '^[0-9,]+$'
            THEN REPLACE(readmissions_raw, ',', '')::INTEGER
        END AS number_of_readmissions,

        CASE WHEN start_raw ~ '^\d{4}-\d{2}-\d{2}$'
            THEN start_raw::DATE
        END AS start_date,

        CASE WHEN end_raw ~ '^\d{4}-\d{2}-\d{2}$'
            THEN end_raw::DATE
        END AS end_date

    FROM normalized
)
SELECT DISTINCT *
FROM typed
WHERE facility_id IS NOT NULL
  AND measure_name IS NOT NULL;




SELECT
    facility_id,
    measure_name,
    start_date,
    end_date,
    COUNT(*) AS record_count
FROM public.hrrp_clean
GROUP BY facility_id, measure_name, start_date, end_date
HAVING COUNT(*) > 1;


SELECT *
FROM public.hrrp_clean
WHERE number_of_discharges < 0
   OR number_of_readmissions < 0
   OR number_of_readmissions > number_of_discharges
   OR excess_readmission_ratio <= 0
   OR predicted_readmission_rate < 0
   OR expected_readmission_rate < 0
   OR start_date > end_date;*/
