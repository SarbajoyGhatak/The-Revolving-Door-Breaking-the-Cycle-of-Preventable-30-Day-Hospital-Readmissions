
/*CREATE TABLE public.hospital_general_information_clean AS
WITH standardized AS (
    SELECT
        NULLIF(UPPER(TRIM("Facility ID")), '') AS facility_id,
        NULLIF(REGEXP_REPLACE(TRIM("Facility Name"), '\s+', ' ', 'g'), '') AS facility_name,
        NULLIF(TRIM("Address"), '') AS address,
        NULLIF(INITCAP(TRIM("City/Town")), '') AS city,
        NULLIF(UPPER(TRIM("State")), '') AS state,
        NULLIF(TRIM("ZIP Code"), '') AS zip_code,
        NULLIF(TRIM("County/Parish"), '') AS county,
        NULLIF(TRIM("Telephone Number"), '') AS telephone_number,
        NULLIF(TRIM("Hospital Type"), '') AS hospital_type,
        NULLIF(TRIM("Hospital Ownership"), '') AS hospital_ownership,
        NULLIF(INITCAP(TRIM("Emergency Services")), '') AS emergency_services,
        NULLIF(TRIM("Meets criteria for birthing friendly designation"), '') AS birthing_friendly_designation,
        NULLIF(TRIM("Hospital overall rating"), '') AS rating_raw,
        NULLIF(TRIM("Hospital overall rating footnote"), '') AS rating_footnote,

        NULLIF(TRIM("MORT Group Measure Count"), '') AS mort_total,
        NULLIF(TRIM("Count of Facility MORT Measures"), '') AS mort_facility,
        NULLIF(TRIM("Count of MORT Measures Better"), '') AS mort_better,
        NULLIF(TRIM("Count of MORT Measures No Different"), '') AS mort_same,
        NULLIF(TRIM("Count of MORT Measures Worse"), '') AS mort_worse,
        NULLIF(TRIM("MORT Group Footnote"), '') AS mort_footnote,

        NULLIF(TRIM("Safety Group Measure Count"), '') AS safety_total,
        NULLIF(TRIM("Count of Facility Safety Measures"), '') AS safety_facility,
        NULLIF(TRIM("Count of Safety Measures Better"), '') AS safety_better,
        NULLIF(TRIM("Count of Safety Measures No Different"), '') AS safety_same,
        NULLIF(TRIM("Count of Safety Measures Worse"), '') AS safety_worse,
        NULLIF(TRIM("Safety Group Footnote"), '') AS safety_footnote,

        NULLIF(TRIM("READM Group Measure Count"), '') AS readm_total,
        NULLIF(TRIM("Count of Facility READM Measures"), '') AS readm_facility,
        NULLIF(TRIM("Count of READM Measures Better"), '') AS readm_better,
        NULLIF(TRIM("Count of READM Measures No Different"), '') AS readm_same,
        NULLIF(TRIM("Count of READM Measures Worse"), '') AS readm_worse,
        NULLIF(TRIM("READM Group Footnote"), '') AS readm_footnote,

        NULLIF(TRIM("Pt Exp Group Measure Count"), '') AS ptexp_total,
        NULLIF(TRIM("Count of Facility Pt Exp Measures"), '') AS ptexp_facility,
        NULLIF(TRIM("Pt Exp Group Footnote"), '') AS ptexp_footnote,

        NULLIF(TRIM("TE Group Measure Count"), '') AS te_total,
        NULLIF(TRIM("Count of Facility TE Measures"), '') AS te_facility,
        NULLIF(TRIM("TE Group Footnote"), '') AS te_footnote

    FROM public.hospital_general_information_raw
),
cleaned AS (
    SELECT
        facility_id,
        facility_name,
        address,
        city,
        state,
        zip_code,
        county,
        telephone_number,
        hospital_type,
        hospital_ownership,
        emergency_services,
        birthing_friendly_designation,

        CASE WHEN rating_raw ~ '^[0-5]$'
            THEN rating_raw::INTEGER END AS hospital_overall_rating,
        rating_footnote,

        CASE WHEN mort_total ~ '^\d+$' THEN mort_total::INTEGER END AS mort_group_measure_count,
        CASE WHEN mort_facility ~ '^\d+$' THEN mort_facility::INTEGER END AS facility_mort_measures,
        CASE WHEN mort_better ~ '^\d+$' THEN mort_better::INTEGER END AS mort_measures_better,
        CASE WHEN mort_same ~ '^\d+$' THEN mort_same::INTEGER END AS mort_measures_no_different,
        CASE WHEN mort_worse ~ '^\d+$' THEN mort_worse::INTEGER END AS mort_measures_worse,
        mort_footnote,

        CASE WHEN safety_total ~ '^\d+$' THEN safety_total::INTEGER END AS safety_group_measure_count,
        CASE WHEN safety_facility ~ '^\d+$' THEN safety_facility::INTEGER END AS facility_safety_measures,
        CASE WHEN safety_better ~ '^\d+$' THEN safety_better::INTEGER END AS safety_measures_better,
        CASE WHEN safety_same ~ '^\d+$' THEN safety_same::INTEGER END AS safety_measures_no_different,
        CASE WHEN safety_worse ~ '^\d+$' THEN safety_worse::INTEGER END AS safety_measures_worse,
        safety_footnote,

        CASE WHEN readm_total ~ '^\d+$' THEN readm_total::INTEGER END AS readm_group_measure_count,
        CASE WHEN readm_facility ~ '^\d+$' THEN readm_facility::INTEGER END AS facility_readm_measures,
        CASE WHEN readm_better ~ '^\d+$' THEN readm_better::INTEGER END AS readm_measures_better,
        CASE WHEN readm_same ~ '^\d+$' THEN readm_same::INTEGER END AS readm_measures_no_different,
        CASE WHEN readm_worse ~ '^\d+$' THEN readm_worse::INTEGER END AS readm_measures_worse,
        readm_footnote,

        CASE WHEN ptexp_total ~ '^\d+$' THEN ptexp_total::INTEGER END AS pt_exp_group_measure_count,
        CASE WHEN ptexp_facility ~ '^\d+$' THEN ptexp_facility::INTEGER END AS facility_pt_exp_measures,
        ptexp_footnote,

        CASE WHEN te_total ~ '^\d+$' THEN te_total::INTEGER END AS te_group_measure_count,
        CASE WHEN te_facility ~ '^\d+$' THEN te_facility::INTEGER END AS facility_te_measures,
        te_footnote

    FROM standardized
)
SELECT DISTINCT *
FROM cleaned
WHERE facility_id IS NOT NULL;


SELECT
    facility_id,
    COUNT(*) AS record_count
FROM public.hospital_general_information_clean
GROUP BY facility_id
HAVING COUNT(*) > 1;

CREATE TABLE public.hospital_information_analysis AS
SELECT DISTINCT
    facility_id,
    facility_name,
    address,
    city,
    state,
    county,
    hospital_type,
    hospital_ownership,
    emergency_services,
    birthing_friendly_designation,
    hospital_overall_rating
FROM public.hospital_general_information_clean;*/
