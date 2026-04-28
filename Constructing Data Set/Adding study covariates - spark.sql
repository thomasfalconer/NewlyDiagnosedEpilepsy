-- ============================================================
-- Newly Diagnosed Epilepsy Cohort - Apache Spark SQL
-- Converted from SQL Server dialect
-- ============================================================
-- Conversion notes:
--   #temp_table              → CREATE OR REPLACE TEMP VIEW
--   SELECT INTO              → CREATE OR REPLACE TEMP VIEW ... AS
--   DATEADD(YEAR, -N, x)    → ADD_MONTHS(x, -N*12)
--   DATEADD(YEAR, N, x)     → ADD_MONTHS(x, N*12)
--   DATEDIFF(day, a, b)     → DATEDIFF(b, a)  [Spark arg order is reversed]
--   DATEDIFF(MONTH, a, b)   → MONTHS_BETWEEN(b, a)
--   ORDER BY removed from view definitions (not valid in Spark views)
--   IF OBJECT_ID ... DROP    → DROP TABLE IF EXISTS
--   SELECT INTO perm_table   → CREATE TABLE ... AS SELECT
-- ============================================================

-- =========================
-- PREDICTOR VARIABLES
-- =========================

-- Brain Tumor
CREATE OR REPLACE TEMP VIEW brain_tumor AS
WITH brain AS (
  SELECT
    a.*,
    co.condition_concept_id AS brain_tumor_concept_id,
    c.concept_name AS brain_tumor_dx,
    co.condition_start_date AS brain_tumor_dx_date,
    ROW_NUMBER() OVER (PARTITION BY a.person_id ORDER BY co.condition_start_date) AS brain_concept_count
  FROM workDatabaseSchema.newly_diagnosed_epilepsy_cohort a
  LEFT JOIN cdmDatabaseSchema.condition_occurrence co
    ON a.person_id = co.person_id
    AND co.condition_concept_id IN (
      SELECT descendant_concept_id FROM cdmDatabaseSchema.concept_ancestor WHERE ancestor_concept_id IN (4116092, 36768862)
    )
    AND co.condition_start_date < a.start_date
  LEFT JOIN cdmDatabaseSchema.concept c
    ON co.condition_concept_id = c.concept_id
)
SELECT * FROM brain WHERE brain_concept_count = 1;


-- Anxiety Disorder
CREATE OR REPLACE TEMP VIEW GAD AS
WITH gad_cte AS (
  SELECT
    a.*,
    co.condition_concept_id AS GAD_concept_id,
    c.concept_name AS GAD_dx,
    co.condition_start_date AS GAD_dx_date,
    ROW_NUMBER() OVER (PARTITION BY a.person_id ORDER BY co.condition_start_date) AS GAD_concept_count
  FROM brain_tumor a
  LEFT JOIN cdmDatabaseSchema.condition_occurrence co
    ON a.person_id = co.person_id
    AND co.condition_concept_id IN (
      SELECT descendant_concept_id FROM cdmDatabaseSchema.concept_ancestor WHERE ancestor_concept_id = 442077
    )
    AND co.condition_start_date BETWEEN ADD_MONTHS(a.start_date, -12) AND a.start_date
  LEFT JOIN cdmDatabaseSchema.concept c
    ON co.condition_concept_id = c.concept_id
)
SELECT * FROM gad_cte WHERE GAD_concept_count = 1;


-- Lesion of Brain
CREATE OR REPLACE TEMP VIEW LOB AS
WITH lob_cte AS (
  SELECT
    a.*,
    co.condition_concept_id AS LOB_concept_id,
    c.concept_name AS LOB_dx,
    co.condition_start_date AS LOB_dx_date,
    ROW_NUMBER() OVER (PARTITION BY a.person_id ORDER BY co.condition_start_date) AS LOB_concept_count
  FROM GAD a
  LEFT JOIN cdmDatabaseSchema.condition_occurrence co
    ON a.person_id = co.person_id
    AND co.condition_concept_id IN (
      SELECT descendant_concept_id FROM cdmDatabaseSchema.concept_ancestor WHERE ancestor_concept_id IN (4200516)
    )
    AND co.condition_start_date < a.start_date
  LEFT JOIN cdmDatabaseSchema.concept c
    ON co.condition_concept_id = c.concept_id
)
SELECT * FROM lob_cte WHERE LOB_concept_count = 1;


-- Tuberous Sclerosis
CREATE OR REPLACE TEMP VIEW TS AS
WITH ts_cte AS (
  SELECT
    a.*,
    co.condition_concept_id AS TS_concept_id,
    co.condition_source_value AS TS_ICD,
    c.concept_name AS TS_dx,
    co.condition_start_date AS TS_dx_date,
    ROW_NUMBER() OVER (PARTITION BY a.person_id ORDER BY co.condition_start_date) AS TS_concept_count
  FROM LOB a
  LEFT JOIN cdmDatabaseSchema.condition_occurrence co
    ON a.person_id = co.person_id
    AND co.condition_concept_id IN (
      SELECT descendant_concept_id FROM cdmDatabaseSchema.concept_ancestor WHERE ancestor_concept_id IN (380839)
    )
    AND co.condition_start_date < a.start_date
  LEFT JOIN cdmDatabaseSchema.concept c
    ON co.condition_concept_id = c.concept_id
)
SELECT * FROM ts_cte WHERE TS_concept_count = 1;


-- Depression
CREATE OR REPLACE TEMP VIEW depression AS
WITH depression_cte AS (
  SELECT
    a.*,
    co.condition_concept_id AS depression_concept_id,
    c.concept_name AS depression_dx,
    co.condition_start_date AS depression_dx_date,
    ROW_NUMBER() OVER (PARTITION BY a.person_id ORDER BY co.condition_start_date) AS depression_concept_count
  FROM TS a
  LEFT JOIN cdmDatabaseSchema.condition_occurrence co
    ON a.person_id = co.person_id
    AND co.condition_concept_id IN (
      SELECT descendant_concept_id FROM cdmDatabaseSchema.concept_ancestor WHERE ancestor_concept_id IN (440383)
    )
    AND co.condition_start_date BETWEEN ADD_MONTHS(a.start_date, -12) AND a.start_date
  LEFT JOIN cdmDatabaseSchema.concept c
    ON co.condition_concept_id = c.concept_id
)
SELECT * FROM depression_cte WHERE depression_concept_count = 1;


-- Migraine (Headache Disorder)
CREATE OR REPLACE TEMP VIEW migraine AS
WITH migraine_cte AS (
  SELECT
    a.*,
    co.condition_concept_id AS migraine_concept_id,
    c.concept_name AS migraine_dx,
    co.condition_start_date AS migraine_dx_date,
    ROW_NUMBER() OVER (PARTITION BY a.person_id ORDER BY co.condition_start_date) AS migraine_concept_count
  FROM depression a
  LEFT JOIN cdmDatabaseSchema.condition_occurrence co
    ON a.person_id = co.person_id
    AND co.condition_concept_id IN (
      SELECT descendant_concept_id FROM cdmDatabaseSchema.concept_ancestor WHERE ancestor_concept_id IN (375527)
    )
    AND co.condition_start_date BETWEEN ADD_MONTHS(a.start_date, -12) AND a.start_date
  LEFT JOIN cdmDatabaseSchema.concept c
    ON co.condition_concept_id = c.concept_id
)
SELECT * FROM migraine_cte WHERE migraine_concept_count = 1;


-- Dementia
CREATE OR REPLACE TEMP VIEW dementia AS
WITH dementia_cte AS (
  SELECT
    a.*,
    co.condition_concept_id AS dementia_concept_id,
    c.concept_name AS dementia_dx,
    co.condition_start_date AS dementia_dx_date,
    ROW_NUMBER() OVER (PARTITION BY a.person_id ORDER BY co.condition_start_date) AS dementia_concept_count
  FROM migraine a
  LEFT JOIN cdmDatabaseSchema.condition_occurrence co
    ON a.person_id = co.person_id
    AND co.condition_concept_id IN (
      SELECT descendant_concept_id FROM cdmDatabaseSchema.concept_ancestor WHERE ancestor_concept_id IN (4182210)
    )
    AND co.condition_start_date < a.start_date
  LEFT JOIN cdmDatabaseSchema.concept c
    ON co.condition_concept_id = c.concept_id
)
SELECT * FROM dementia_cte WHERE dementia_concept_count = 1;


-- Traumatic Brain Injury
CREATE OR REPLACE TEMP VIEW TBI AS
WITH tbi_cte AS (
  SELECT
    a.*,
    co.condition_concept_id AS TBI_concept_id,
    c.concept_name AS TBI_dx,
    co.condition_start_date AS TBI_dx_date,
    ROW_NUMBER() OVER (PARTITION BY a.person_id ORDER BY co.condition_start_date) AS TBI_concept_count
  FROM dementia a
  LEFT JOIN cdmDatabaseSchema.condition_occurrence co
    ON a.person_id = co.person_id
    AND co.condition_concept_id IN (
      SELECT descendant_concept_id FROM cdmDatabaseSchema.concept_ancestor WHERE ancestor_concept_id IN (4132546)
    )
    AND co.condition_start_date < a.start_date
  LEFT JOIN cdmDatabaseSchema.concept c
    ON co.condition_concept_id = c.concept_id
)
SELECT * FROM tbi_cte WHERE TBI_concept_count = 1;


-- Generalized Epilepsy
CREATE OR REPLACE TEMP VIEW generalized AS
WITH focal_epilepsy AS (
  SELECT DISTINCT
    a.person_id,
    a.start_date AS index_date,
    c1.condition_start_date AS focal_dx_date
  FROM workDatabaseSchema.newly_diagnosed_epilepsy_cohort a
  JOIN cdmDatabaseSchema.condition_occurrence c1 ON a.person_id = c1.person_id
  WHERE c1.condition_concept_id IN (
    36674783, 37110674, 37166916, 37110524, 37118656,
    374915, 37110163, 37205067, 3657974
  )
    AND c1.condition_start_date < a.start_date
),
generalized_cte AS (
  SELECT
    a.*,
    co.condition_concept_id AS Generalized_epilepsy_concept_id,
    c.concept_name AS Generalized_epilepsy_dx,
    co.condition_start_date AS Generalized_epilepsy_dx_date,
    ROW_NUMBER() OVER (PARTITION BY a.person_id ORDER BY co.condition_start_date) AS generalized_epilepsy_concept_count
  FROM TBI a
  LEFT JOIN cdmDatabaseSchema.condition_occurrence co
    ON a.person_id = co.person_id
    AND co.condition_concept_id IN (
      43530704, 37397175, 36680607, 37168142, 36716897,
      37205064, 4055361, 4147501, 4232071
    )
    AND co.condition_start_date < a.start_date
  LEFT JOIN cdmDatabaseSchema.concept c
    ON co.condition_concept_id = c.concept_id
  WHERE NOT EXISTS (
    SELECT 1 FROM focal_epilepsy f WHERE f.person_id = a.person_id
  )
)
SELECT * FROM generalized_cte WHERE generalized_epilepsy_concept_count = 1;


-- Focal Epilepsy
CREATE OR REPLACE TEMP VIEW focal AS
WITH general_epilepsy AS (
  SELECT DISTINCT
    a.person_id,
    a.start_date AS index_date,
    c1.condition_start_date AS focal_dx_date
  FROM workDatabaseSchema.newly_diagnosed_epilepsy_cohort a
  JOIN cdmDatabaseSchema.condition_occurrence c1 ON a.person_id = c1.person_id
  WHERE c1.condition_concept_id IN (
    43530704, 37397175, 36680607, 37168142, 36716897,
    37205064, 4055361, 4147501, 4232071
  )
    AND c1.condition_start_date < a.start_date
),
focal_cte AS (
  SELECT
    a.*,
    co.condition_concept_id AS Focal_epilepsy_concept_id,
    c.concept_name AS Focal_epilepsy_dx,
    co.condition_start_date AS Focal_epilepsy_dx_date,
    ROW_NUMBER() OVER (PARTITION BY a.person_id ORDER BY co.condition_start_date) AS focal_epilepsy_concept_count
  FROM generalized a
  LEFT JOIN cdmDatabaseSchema.condition_occurrence co
    ON a.person_id = co.person_id
    AND co.condition_concept_id IN (
      36674783, 37110674, 37166916, 37110524, 37118656,
      374915, 37110163, 37205067, 3657974
    )
    AND co.condition_start_date < a.start_date
  LEFT JOIN cdmDatabaseSchema.concept c
    ON co.condition_concept_id = c.concept_id
  WHERE NOT EXISTS (
    SELECT 1 FROM general_epilepsy f WHERE f.person_id = a.person_id
  )
)
SELECT * FROM focal_cte WHERE focal_epilepsy_concept_count = 1;


-- =========================
-- IMAGING COLUMNS
-- =========================

-- CT Head
CREATE OR REPLACE TEMP VIEW CT AS
WITH ct_cte AS (
  SELECT
    a.*,
    po.procedure_concept_id AS CT_concept_id,
    c.concept_name AS CT_concept,
    po.procedure_date AS CT_date,
    ROW_NUMBER() OVER (PARTITION BY a.person_id ORDER BY po.procedure_date) AS ct_concept_count
  FROM focal a
  LEFT JOIN cdmDatabaseSchema.procedure_occurrence po
    ON a.person_id = po.person_id
    AND po.procedure_concept_id IN (
      SELECT descendant_concept_id FROM cdmDatabaseSchema.concept_ancestor WHERE ancestor_concept_id = 4125350
    )
    AND po.procedure_date BETWEEN ADD_MONTHS(a.start_date, -12) AND a.start_date
  LEFT JOIN cdmDatabaseSchema.concept c ON po.procedure_concept_id = c.concept_id
)
SELECT * FROM ct_cte WHERE ct_concept_count = 1;


-- =========================
-- NDE OUTCOME VARIABLES
-- =========================

-- Visit Types
CREATE OR REPLACE TEMP VIEW visit_types AS
WITH seizures AS (
  SELECT descendant_concept_id AS concept_id
  FROM cdmDatabaseSchema.concept_ancestor
  WHERE ancestor_concept_id IN (380378)
)
SELECT DISTINCT
  a.*,
  c.concept_name AS diagnosis,
  co.CONDITION_CONCEPT_ID,
  co.condition_start_date AS encounter_date,
  DATEDIFF(co.condition_start_date, a.start_date) AS Encounter_day_diff_from_index,
  co.visit_occurrence_id AS co_visit_occurrence_id,
  vo.visit_concept_id,
  vo.visit_occurrence_id AS vo_visit_occurrence_id
FROM workDatabaseSchema.newly_diagnosed_epilepsy_cohort a
JOIN cdmDatabaseSchema.condition_occurrence co ON a.person_id = co.person_id
JOIN cdmDatabaseSchema.visit_occurrence vo ON co.visit_occurrence_id = vo.visit_occurrence_id
JOIN cdmDatabaseSchema.concept c ON co.condition_concept_id = c.concept_id
WHERE co.condition_concept_id IN (SELECT DISTINCT concept_id FROM seizures)
  AND co.condition_start_date BETWEEN ADD_MONTHS(a.start_date, -24) AND ADD_MONTHS(a.start_date, 24);


-- Distinct rows with year classification
CREATE OR REPLACE TEMP VIEW visit_types_distinct AS
SELECT DISTINCT
  person_id,
  start_date AS index_date,
  end_date,
  encounter_date,
  Encounter_day_diff_from_index,
  CASE
    WHEN ABS(Encounter_day_diff_from_index) <= 365 THEN 'within first year from index'
    ELSE 'within second year from index'
  END AS year_of_visit,
  diagnosis,
  CONDITION_CONCEPT_ID,
  co_visit_occurrence_id,
  visit_concept_id,
  vo_visit_occurrence_id
FROM visit_types;


-- Visit type description
CREATE OR REPLACE TEMP VIEW visit_names AS
SELECT
  a.*,
  c.concept_name AS visit_type
FROM visit_types_distinct a
JOIN cdmDatabaseSchema.concept c ON a.visit_concept_id = c.concept_id
WHERE a.co_visit_occurrence_id = a.vo_visit_occurrence_id;


-- Distinct encounters per person
CREATE OR REPLACE TEMP VIEW distinct_encounters AS
SELECT DISTINCT
  person_id,
  encounter_date,
  Encounter_day_diff_from_index,
  year_of_visit,
  CONDITION_CONCEPT_ID,
  visit_type,
  visit_concept_id
FROM visit_names;


-- Visit type counts per person
CREATE OR REPLACE TEMP VIEW visit_type_count_pp AS
SELECT
  person_id,
  visit_concept_id,
  visit_type,
  year_of_visit,
  COUNT(*) AS visit_type_count
FROM distinct_encounters
GROUP BY person_id, visit_concept_id, visit_type, year_of_visit;


-- IP visits 1 year
CREATE OR REPLACE TEMP VIEW IP_visit_1yr AS
SELECT person_id, visit_type_count AS IP_visit_count_1yr
FROM visit_type_count_pp
WHERE visit_concept_id = 9201
  AND year_of_visit = 'within first year from index';

CREATE OR REPLACE TEMP VIEW NO_IP_visit_1yr AS
SELECT DISTINCT person_id, 0 AS IP_visit_count_1yr
FROM visit_types
WHERE person_id NOT IN (SELECT DISTINCT person_id FROM IP_visit_1yr);

CREATE OR REPLACE TEMP VIEW ingested_IP_visit_1yr AS
SELECT * FROM IP_visit_1yr
UNION ALL
SELECT * FROM NO_IP_visit_1yr;

CREATE OR REPLACE TEMP VIEW IP_visit_1yr_done AS
SELECT a.*, b.IP_visit_count_1yr
FROM CT a
JOIN ingested_IP_visit_1yr b ON a.person_id = b.person_id;


-- IP visits 2 year
CREATE OR REPLACE TEMP VIEW IP_visit_2yr AS
SELECT person_id, visit_type_count AS IP_visit_count_2yr
FROM visit_type_count_pp
WHERE visit_concept_id = 9201
  AND year_of_visit = 'within second year from index';

CREATE OR REPLACE TEMP VIEW NO_IP_visit_2yr AS
SELECT DISTINCT person_id, 0 AS IP_visit_count_2yr
FROM visit_types
WHERE person_id NOT IN (SELECT DISTINCT person_id FROM IP_visit_2yr);

CREATE OR REPLACE TEMP VIEW ingested_IP_visit_2yr AS
SELECT * FROM IP_visit_2yr
UNION ALL
SELECT * FROM NO_IP_visit_2yr;

CREATE OR REPLACE TEMP VIEW IP_visit_2yr_done AS
SELECT a.*, b.IP_visit_count_2yr
FROM IP_visit_1yr_done a
JOIN ingested_IP_visit_2yr b ON a.person_id = b.person_id;


-- OP visits 1 year
CREATE OR REPLACE TEMP VIEW OP_visit_1yr AS
SELECT person_id, SUM(visit_type_count) AS OP_visit_count_1yr
FROM visit_type_count_pp
WHERE visit_concept_id IN (9202, 581477, 8756)
  AND year_of_visit = 'within first year from index'
GROUP BY person_id;

CREATE OR REPLACE TEMP VIEW NO_OP_visit_1yr AS
SELECT DISTINCT person_id, 0 AS OP_visit_count_1yr
FROM visit_types
WHERE person_id NOT IN (SELECT DISTINCT person_id FROM OP_visit_1yr);

CREATE OR REPLACE TEMP VIEW ingested_OP_visit_1yr AS
SELECT * FROM OP_visit_1yr
UNION ALL
SELECT * FROM NO_OP_visit_1yr;

CREATE OR REPLACE TEMP VIEW OP_visit_1yr_done AS
SELECT a.*, b.OP_visit_count_1yr
FROM IP_visit_2yr_done a
JOIN ingested_OP_visit_1yr b ON a.person_id = b.person_id;


-- OP visits 2 year
CREATE OR REPLACE TEMP VIEW OP_visit_2yr AS
SELECT person_id, SUM(visit_type_count) AS OP_visit_count_2yr
FROM visit_type_count_pp
WHERE visit_concept_id IN (9202, 581477, 8756)
  AND year_of_visit = 'within second year from index'
GROUP BY person_id;

CREATE OR REPLACE TEMP VIEW NO_OP_visit_2yr AS
SELECT DISTINCT person_id, 0 AS OP_visit_count_2yr
FROM visit_types
WHERE person_id NOT IN (SELECT DISTINCT person_id FROM OP_visit_2yr);

CREATE OR REPLACE TEMP VIEW ingested_OP_visit_2yr AS
SELECT * FROM OP_visit_2yr
UNION ALL
SELECT * FROM NO_OP_visit_2yr;

CREATE OR REPLACE TEMP VIEW OP_visit_2yr_done AS
SELECT a.*, b.OP_visit_count_2yr
FROM OP_visit_1yr_done a
JOIN ingested_OP_visit_2yr b ON a.person_id = b.person_id;


-- MRI Brain 2 years
CREATE OR REPLACE TEMP VIEW mri AS
WITH mri_cte AS (
  SELECT
    a.*,
    po.procedure_concept_id AS MRI_2year_concept_id,
    c.concept_name AS MRI_2year_concept,
    po.procedure_date AS MRI_2year_date,
    ROW_NUMBER() OVER (PARTITION BY a.person_id ORDER BY po.procedure_date) AS mri_concept_count
  FROM OP_visit_2yr_done a
  LEFT JOIN cdmDatabaseSchema.procedure_occurrence po
    ON a.person_id = po.person_id
    AND po.procedure_concept_id IN (
      SELECT descendant_concept_id FROM cdmDatabaseSchema.concept_ancestor WHERE ancestor_concept_id = 37311324
    )
    AND po.procedure_date BETWEEN ADD_MONTHS(a.start_date, -24) AND ADD_MONTHS(a.start_date, 24)
  LEFT JOIN cdmDatabaseSchema.concept c ON po.procedure_concept_id = c.concept_id
)
SELECT * FROM mri_cte WHERE mri_concept_count = 1;


-- Any EEG 2 year
CREATE OR REPLACE TEMP VIEW eeg AS
WITH eeg_cte AS (
  SELECT
    a.*,
    po.procedure_concept_id AS EEG_2year_concept_id,
    po.procedure_source_value AS EEG_2year_CPT,
    c.concept_name AS EEG_2year_concept,
    po.procedure_date AS EEG_2year_date,
    ROW_NUMBER() OVER (PARTITION BY a.person_id ORDER BY po.procedure_date) AS eeg_concept_count
  FROM mri a
  LEFT JOIN cdmDatabaseSchema.procedure_occurrence po
    ON a.person_id = po.person_id
    AND po.procedure_concept_id IN (
      SELECT descendant_concept_id FROM cdmDatabaseSchema.concept_ancestor WHERE ancestor_concept_id IN (4181917)
    )
    AND po.procedure_date BETWEEN ADD_MONTHS(a.start_date, -24) AND ADD_MONTHS(a.start_date, 24)
  LEFT JOIN cdmDatabaseSchema.concept c ON po.procedure_concept_id = c.concept_id
)
SELECT * FROM eeg_cte WHERE eeg_concept_count = 1;


-- =========================
-- DEMOGRAPHIC VARIABLES
-- =========================
CREATE OR REPLACE TEMP VIEW demo_variables AS
SELECT DISTINCT
  a.person_id,
  b.gender_concept_id,
  ROUND(MONTHS_BETWEEN(a.start_date, b.birth_datetime) / 12.0, 2) AS Age,
  b.race_source_value AS Race,
  b.ethnicity_source_value AS Ethnicity
FROM workDatabaseSchema.newly_diagnosed_epilepsy_cohort a
JOIN cdmDatabaseSchema.person b ON a.person_id = b.person_id;

CREATE OR REPLACE TEMP VIEW demo_variables_done AS
SELECT DISTINCT
  a.*,
  b.gender_concept_id,
  b.Age,
  b.Race,
  b.Ethnicity
FROM eeg a
JOIN demo_variables b ON a.person_id = b.person_id;


-- Observation time post index
CREATE OR REPLACE TEMP VIEW observation_time_post_index AS
SELECT
  a.person_id,
  MAX(b.visit_start_date) AS max_visit_encounter_date
FROM demo_variables_done a
JOIN cdmDatabaseSchema.visit_occurrence b ON a.person_id = b.person_id
GROUP BY a.person_id;

CREATE OR REPLACE TEMP VIEW observation_time_done AS
SELECT DISTINCT
  a.*,
  b.max_visit_encounter_date AS last_follow_up_date
FROM demo_variables_done a
JOIN observation_time_post_index b ON a.person_id = b.person_id;


-- =========================
-- FINAL OUTPUT
-- =========================
CREATE OR REPLACE TEMP VIEW NDE_cohort_done AS
SELECT * FROM observation_time_done
UNION
SELECT * FROM observation_time_done;

-- Persist as permanent table
DROP TABLE IF EXISTS workDatabaseSchema.newly_diagnosed_epilepsy_cohort_with_covariates;

CREATE TABLE workDatabaseSchema.newly_diagnosed_epilepsy_cohort_with_covariates AS
SELECT * FROM NDE_cohort_done;
