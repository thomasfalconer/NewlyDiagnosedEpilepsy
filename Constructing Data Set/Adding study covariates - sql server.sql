

--------------------------------------------------------
-----Newly Diagnosed Epilepsy Cohort----
--------------------------------------------------------


---------------------------------------------------------------------------------------------
------PREDICTORS VARIABLES (OF OUTCOME VARIABLES) -----------
---------------------------------------------------------------------------------------------

--------------------------
--brain tumor field--
--------------------------

--selecting the folks who have the dx
with brain as (
select 
  a.*
, co.condition_concept_id as brain_tumor_concept_id
--, co.condition_source_value as brain_tumor_ICD
,  c.concept_name as brain_tumor_dx
, co.condition_start_date as brain_tumor_dx_date 
, ROW_NUMBER() OVER (PARTITION BY a.person_id ORDER BY co.condition_start_date) as brain_concept_count 
from @workDatabaseSchema.newly_diagnosed_epilepsy_cohort a 
LEFT JOIN @cdmDatabaseSchema.condition_occurrence co ON a.person_id=co.person_id
	AND co.condition_concept_id in 
	(select descendant_concept_id from @cdmDatabaseSchema.concept_ancestor where ancestor_concept_id in ( 4116092, 36768862))
	AND co.condition_start_date < a.start_date ---added new look back filter on 7/30/25 to reflect new look back period using only PAT ENC DX table 
LEFT JOIN @cdmDatabaseSchema.concept c ON co.condition_concept_id=c.concept_id
---AND co.source_table = 'PAT_ENC_DX' ---Added filter on 7/30/25 to apply to each condition covariate
)
select *
INTO #brain_tumor
from brain
where brain_concept_count = 1 
order by person_id; 


 --------------------------------------
 --Anxiety Disorder field ------
 -------------------------------------
 with gad as (
 select 
  a.*
, co.condition_concept_id as GAD_concept_id
--, co.condition_source_value as GAD_ICD
,  c.concept_name as GAD_dx
, co.condition_start_date as GAD_dx_date 
, ROW_NUMBER() OVER (PARTITION BY a.person_id ORDER BY co.condition_start_date) as GAD_concept_count 
from #brain_tumor a
LEFT JOIN @cdmDatabaseSchema.condition_occurrence co ON a.person_id=co.person_id
	AND co.condition_concept_id in 
	(select descendant_concept_id from @cdmDatabaseSchema.concept_ancestor where ancestor_concept_id = 442077) --July 31, 2025 updated code from GAD to Anxiety Disorder
	AND co.condition_start_date BETWEEN dateadd(YEAR, -1, a.start_date)  and a.start_date --one year look back
LEFT JOIN @cdmDatabaseSchema.concept c ON co.condition_concept_id=c.concept_id
---AND co.source_table = 'PAT_ENC_DX' ---Added filter on 7/30/25 to apply to each condition covariate
)
select *
INTO #GAD
from gad
where GAD_concept_count = 1 
order by person_id; 



    -----------------------
 -----Lesion of Brain---
 -----------------------

 with LoB as (
 select 
  a.*
, co.condition_concept_id as LOB_concept_id
--, co.condition_source_value as lesion_ICD
,  c.concept_name as LOB_dx
, co.condition_start_date as LOB_dx_date 
, ROW_NUMBER() OVER (PARTITION BY a.person_id ORDER BY co.condition_start_date) as LOB_concept_count 
from #GAD a 
LEFT JOIN @cdmDatabaseSchema.condition_occurrence co ON a.person_id=co.person_id
	AND co.condition_concept_id in 
    (select descendant_concept_id from @cdmDatabaseSchema.concept_ancestor where ancestor_concept_id in (4200516))  --lesion of brain concept id 
    AND co.condition_start_date < a.start_date --all time look back 
LEFT JOIN @cdmDatabaseSchema.concept c ON co.condition_concept_id=c.concept_id
---AND co.source_table = 'PAT_ENC_DX' ---Added filter on 7/30/25 to apply to each condition covariate
)
select *
INTO #LOB
from LoB
where LOB_concept_count = 1 
order by person_id; 


  ----------------------------------
 ---Tuberous Sclerosis field-----
 ----------------------------------

 with TS as (
 select 
  a.*
, co.condition_concept_id as TS_concept_id
, co.condition_source_value as TS_ICD
,  c.concept_name as TS_dx
, co.condition_start_date as TS_dx_date 
, ROW_NUMBER() OVER (PARTITION BY a.person_id ORDER BY co.condition_start_date) as TS_concept_count 
from #LOB a 
LEFT JOIN @cdmDatabaseSchema.condition_occurrence co ON a.person_id=co.person_id
	AND co.condition_concept_id in 
	(select descendant_concept_id from @cdmDatabaseSchema.concept_ancestor where ancestor_concept_id in (380839))
	AND co.condition_start_date < a.start_date ---added new look back filter on 7/30/25 to reflect new look back period using only PAT ENC DX table 
LEFT JOIN @cdmDatabaseSchema.concept c ON co.condition_concept_id=c.concept_id
---AND co.source_table = 'PAT_ENC_DX' ---Added filter on 7/30/25 to apply to each condition covariate
)
select *
INTO #TS
from TS
where TS_concept_count = 1 
order by person_id; 


   ---------------------------------
 ---Depression field-----
 ----------------------------------

 with depression as (
 select 
  a.*
, co.condition_concept_id as depression_concept_id
--, co.condition_source_value as depression_ICD
,  c.concept_name as depression_dx
, co.condition_start_date as depression_dx_date 
, ROW_NUMBER() OVER (PARTITION BY a.person_id ORDER BY co.condition_start_date) as depression_concept_count 
from #TS a 
LEFT JOIN @cdmDatabaseSchema.condition_occurrence co ON a.person_id=co.person_id
	AND co.condition_concept_id in 
	(select descendant_concept_id from @cdmDatabaseSchema.concept_ancestor where ancestor_concept_id in (440383))
	AND co.condition_start_date BETWEEN dateadd(YEAR, -1, a.start_date)  and a.start_date ---one year look back
LEFT JOIN @cdmDatabaseSchema.concept c ON co.condition_concept_id=c.concept_id
---AND co.source_table = 'PAT_ENC_DX' ---Added filter on 7/30/25 to apply to each condition covariate
)
select *
INTO #depression
from depression
where depression_concept_count = 1 
order by person_id; 


 ----------------------------------
 ---Migraine field-----
 ----------------------------------

 with migraine as (
 select 
  a.*
, co.condition_concept_id as migraine_concept_id
--, co.condition_source_value as migraine_ICD
,  c.concept_name as migraine_dx
, co.condition_start_date as migraine_dx_date 
, ROW_NUMBER() OVER (PARTITION BY a.person_id ORDER BY co.condition_start_date) as migraine_concept_count 
from #depression a 
LEFT JOIN @cdmDatabaseSchema.condition_occurrence co ON a.person_id=co.person_id
	AND co.condition_concept_id in 
	(select descendant_concept_id from @cdmDatabaseSchema.concept_ancestor where ancestor_concept_id in (375527))  --headache disorder (this parent subsumes migraine codes)
	AND co.condition_start_date BETWEEN dateadd(YEAR, -1, a.start_date)  and a.start_date  ---1 year look back 
LEFT JOIN @cdmDatabaseSchema.concept c ON co.condition_concept_id=c.concept_id
---AND co.source_table = 'PAT_ENC_DX' ---Added filter on 7/30/25 to apply to each condition covariate
)
select *
INTO #migraine
from migraine 
where migraine_concept_count = 1 
order by person_id; 


  -----------------
 -----Dementia---
 -----------------

 with dementia as (
 select 
  a.*
, co.condition_concept_id as dementia_concept_id
--, co.condition_source_value as dementia_ICD
,  c.concept_name as dementia_dx
, co.condition_start_date as dementia_dx_date 
, ROW_NUMBER() OVER (PARTITION BY a.person_id ORDER BY co.condition_start_date) as dementia_concept_count 
from #migraine a 
LEFT JOIN @cdmDatabaseSchema.condition_occurrence co ON a.person_id=co.person_id
	AND co.condition_concept_id in 
	(select descendant_concept_id from @cdmDatabaseSchema.concept_ancestor where ancestor_concept_id in (4182210))  --dementia concept id 
	AND co.condition_start_date < a.start_date --all time look back 
LEFT JOIN @cdmDatabaseSchema.concept c ON co.condition_concept_id=c.concept_id

---AND co.source_table = 'PAT_ENC_DX' ---Added filter on 7/30/25 to apply to each condition covariate
)
select *
INTO #dementia
from dementia  
where dementia_concept_count = 1 
order by person_id; 


  -----------------------------
 -----Tramautic Brain Injury---
 ------------------------------

 with TBI as (
 select 
  a.*
, co.condition_concept_id as TBI_concept_id
--, co.condition_source_value as TBI_ICD
,  c.concept_name as TBI_dx
, co.condition_start_date as TBI_dx_date 
, ROW_NUMBER() OVER (PARTITION BY a.person_id ORDER BY co.condition_start_date) as TBI_concept_count 
from #dementia a 
LEFT JOIN @cdmDatabaseSchema.condition_occurrence co ON a.person_id=co.person_id
	AND co.condition_concept_id in 
	(select descendant_concept_id from @cdmDatabaseSchema.concept_ancestor where ancestor_concept_id in (4132546))  --TBI concept id 
	AND co.condition_start_date < a.start_date --all time look back 
LEFT JOIN @cdmDatabaseSchema.concept c ON co.condition_concept_id=c.concept_id

---AND co.source_table = 'PAT_ENC_DX' ---Added filter on 7/30/25 to apply to each condition covariate
)
select *
INTO #TBI
from TBI  
where TBI_concept_count = 1 
order by person_id; 

  ----------------------------------
 ---Generalized Epilepsy field-----
 ----------------------------------

with focal_epilepsy as ( ---this cte finds all the folks of the cohort who have a focal dx in the same time window as the general dx searches
select distinct 
  a.person_id
, a.start_date as index_date
, c1.condition_start_date as focal_dx_date
from @workDatabaseSchema.newly_diagnosed_epilepsy_cohort a 
JOIN @cdmDatabaseSchema.condition_occurrence c1 ON a.person_id=c1.person_id
where c1.condition_concept_id in ( --focal epilepsy SNOMED concepts 
36674783
,37110674
,37166916
,37110524
,37118656
,374915
,37110163
,37205067
,3657974
)
--AND c1.condition_start_date BETWEEN  dateadd(YEAR, -5, a.start_date) AND a.start_date --ILAE change (not looking post index date since it is a predictor)
AND c1.condition_start_date < a.start_date
--AND c1.source_table = 'PAT_ENC_DX'
), --end focal cte
generalized as (
SELECT 
    a.*,
    co.condition_concept_id as Generalized_epilepsy_concept_id,
--	co.condition_source_value as Generalized_epilepsy_ICD,
    c.concept_name as Generalized_epilepsy_dx,
    co.condition_start_date as Generalized_epilepsy_dx_date 
, ROW_NUMBER() OVER (PARTITION BY a.person_id ORDER BY co.condition_start_date) as generalized_epilepsy_concept_count 
FROM #TBI a 
LEFT JOIN @cdmDatabaseSchema.condition_occurrence co ON a.person_id = co.person_id
AND co.condition_concept_id IN (
43530704
,37397175
,36680607
,37168142
,36716897
,37205064
,4055361
,4147501
,4232071
	)
--AND co.condition_start_date BETWEEN dateadd(YEAR, -2, a.start_date) AND a.start_date --ILAE change (not looking post index date)
AND co.condition_start_date < a.start_date
LEFT JOIN @cdmDatabaseSchema.concept c ON co.condition_concept_id = c.concept_id
---AND co.source_table = 'PAT_ENC_DX'
AND NOT EXISTS ( ---this not exists tells sql to populate the general column with a 1 only for the folks who are NOT IN the focal_epilepsy list 
    SELECT 1 
    FROM focal_epilepsy f 
    WHERE f.person_id = a.person_id
)
)
select *
INTO #generalized
from generalized
where generalized_epilepsy_concept_count = 1 
order by person_id; 
	

 ----------------------------------
 ---Focal Epilepsy field-----
 ----------------------------------

with general_epilepsy as ( ---this cte finds all the folks of the cohort who have a general dx in the same time window as the focal dx searches
select distinct 
  a.person_id
, a.start_date as index_date
, c1.condition_start_date as focal_dx_date
from @workDatabaseSchema.newly_diagnosed_epilepsy_cohort a 
JOIN @cdmDatabaseSchema.condition_occurrence c1 ON a.person_id=c1.person_id
where c1.condition_concept_id in ( --general epilepsy SNOMED concepts 
43530704
,37397175
,36680607
,37168142
,36716897
,37205064
,4055361
,4147501
,4232071
)
--AND c1.condition_start_date BETWEEN  dateadd(YEAR, -2, a.start_date) AND a.start_date --general dx from -10 years from index date to index date
AND c1.condition_start_date < a.start_date
--AND c1.source_table = 'PAT_ENC_DX'
), --end general cte
focal as (
SELECT 
    a.*,
    co.condition_concept_id as Focal_epilepsy_concept_id,
	--co.condition_source_value as Focal_epilepsy_ICD,
    c.concept_name as Focal_epilepsy_dx,
    co.condition_start_date as Focal_epilepsy_dx_date 
, ROW_NUMBER() OVER (PARTITION BY a.person_id ORDER BY co.condition_start_date) as focal_epilepsy_concept_count 
FROM #generalized a 
LEFT JOIN @cdmDatabaseSchema.condition_occurrence co ON a.person_id = co.person_id
AND co.condition_concept_id IN (
36674783
,37110674
,37166916
,37110524
,37118656
,374915
,37110163
,37205067
,3657974
	)
--AND co.condition_start_date BETWEEN dateadd(YEAR, -2, a.start_date) AND a.start_date
AND co.condition_start_date < a.start_date
LEFT JOIN @cdmDatabaseSchema.concept c ON co.condition_concept_id = c.concept_id
---AND co.source_table = 'PAT_ENC_DX'
AND NOT EXISTS ( ---this not exists tells sql to populate the focal column with a 1 only for the folks who are NOT IN the genearl_epilepsy cte 
    SELECT 1 
    FROM general_epilepsy f 
    WHERE f.person_id = a.person_id
)
)
select *
INTO #focal
from focal
where focal_epilepsy_concept_count = 1 
order by person_id; 

 

 ------------------------------------------------
 ----------IMAGING COLUMNS-----------
 ------------------------------------------------

 -------------------
 ---CT Head----
 -------------------
 with ct as (
select 
  a.*
, po.procedure_concept_id as CT_concept_id
--, po.procedure_source_value as CT_CPT
,  c.concept_name as CT_concept
, po.procedure_date as CT_date 
, ROW_NUMBER() OVER (PARTITION BY a.person_id ORDER BY po.procedure_date) as ct_concept_count 
from #focal a 
LEFT JOIN @cdmDatabaseSchema.procedure_occurrence po ON a.person_id=po.person_id
AND po.procedure_concept_id in 
(select descendant_concept_id from @cdmDatabaseSchema.concept_ancestor where ancestor_concept_id = 4125350) --CT head
AND po.procedure_date BETWEEN dateadd(YEAR, -1, a.start_date)  and a.start_date --1 year look back in accordance with ILAE protocol 
LEFT JOIN @cdmDatabaseSchema.concept c ON po.procedure_concept_id=c.concept_id
)
 select *
INTO #CT
from ct
where ct_concept_count = 1 
order by person_id; 


 ----------------------------------------------------
 ------NDE OUTCOME VARIABLES-------
 ----------------------------------------------------

  ------------------------
 ----Visit Type Field---- (Visit types will be used as both a predictor variable and an outcome variable in the NDE data set 
 ------------------------

---prep work for population of Inpatient and outpatient outcome columns

 with seizures as (
 select descendant_concept_id as concept_id
 from @cdmDatabaseSchema.concept_ancestor
 where ancestor_concept_id in (
 --  377091 --ILAE SNOMED code for seizure
 380378 --ILAE SNOMED code for epilepsy
 )
 )
select distinct 
  a.*
,  c.concept_name as diagnosis
, co.CONDITION_CONCEPT_ID
--, co.condition_source_value
, co.condition_start_date as encounter_date
, DATEDIFF(day, a.start_date, co.condition_start_date) as Encounter_day_diff_from_index
--, co.condition_status_source_value
, co.visit_occurrence_id as co_visit_occurrence_id
--, co.source_table as Diagnosis_setting
, vo.visit_concept_id
--, vo.visit_source_value
, vo.visit_occurrence_id as vo_visit_occurrence_id
INTO #visit_types
from @workDatabaseSchema.newly_diagnosed_epilepsy_cohort a
JOIN @cdmDatabaseSchema.condition_occurrence co ON a.person_id=co.person_id 
JOIN @cdmDatabaseSchema.visit_occurrence vo ON co.visit_occurrence_id=vo.visit_occurrence_id
JOIN @cdmDatabaseSchema.concept c ON co.condition_concept_id=c.concept_id 
where co.condition_concept_id in (select distinct concept_id from seizures)
AND  co.condition_start_date BETWEEN dateadd(YEAR, -2, a.start_date)  and dateadd(YEAR, 2, a.start_date) 
---AND co.source_table = 'PAT_ENC_DX' ---added 7/30/25 to reflect source table decision
order by person_id, condition_start_date



--distinct rows
select distinct 
  person_id
, start_date as index_date
, end_date
, encounter_date
, Encounter_day_diff_from_index
, case
	  when ABS(Encounter_day_diff_from_index) <= 365 then 'within first year from index'
	  else 'within second year from index'
end as year_of_visit
, diagnosis
, CONDITION_CONCEPT_ID
, co_visit_occurrence_id
--, Diagnosis_setting
, visit_concept_id
, vo_visit_occurrence_id
into #visit_types_distinct
from #visit_types
order by person_id, encounter_date



---get visit type description
select 
  a.*
, c.concept_name as visit_type
INTO #visit_names
from #visit_types_distinct a
JOIN @cdmDatabaseSchema.concept c ON a.visit_concept_id=c.concept_id
WHERE co_visit_occurrence_id=vo_visit_occurrence_id
order by person_id
, encounter_date



--get distinct encounters per person 
select distinct
person_id
, encounter_date
, Encounter_day_diff_from_index
, year_of_visit
, CONDITION_CONCEPT_ID
, visit_type
, visit_concept_id
into #distinct_encounters
from #visit_names


SELECT distinct
    person_id,
	visit_concept_id ,
    visit_type,
	year_of_visit,
    COUNT(*) AS visit_type_count
INTO #visit_type_count_pp
FROM #distinct_encounters
group by person_id, visit_concept_id, visit_type, year_of_visit
order by person_id, visit_concept_id, visit_type, year_of_visit

--look at data 

select *
from #visit_type_count_pp
where person_id = 210467
order by person_id, visit_type_count, year_of_visit

-------------------
---ED TO IP field--
-------------------
--select 
--person_id
--, visit_type_count as ED_to_IP_visit
--INTO #ED_to_IP_visit 
--from #visit_type_count_pp a
--where visit_concept_id = 262 --ED to IP 
--order by person_id 

----nos
--select 
--person_id
--, "0" as ED_to_IP_visit
--INTO #NO_ED_to_IP_visit 
--from #visit_types a
--where person_id NOT IN (select distinct person_id from #ED_to_IP_visit)

----stack patient sets
-- select *
-- INTO #ingested_ED_TO_IP_visit 
-- from #ED_TO_IP_visit
-- UNION 
-- select * 
-- from #NO_ED_TO_IP_visit
-- ORDER BY person_id


--  ---appending to main table 
--  select 
--   a.*
-- , b.ED_to_IP_visit
-- INTO #ED_to_IP_visit_done
-- from #CT_head_done a 
-- JOIN #ingested_ED_TO_IP_visit b ON a.person_id=b.person_id 
-- order by a.person_id 

-- select *
-- from #ED_to_IP_visit_done
-- order by person_id 

 ----------------------------
 ---IP visit field 1 year
 ---------------------------
select 
person_id
, visit_type_count as IP_visit_count_1yr
INTO #IP_visit_1yr
from #visit_type_count_pp a
where visit_concept_id = 9201 --Inpatient 
		AND year_of_visit = 'within first year from index' --encounter was within 1yr from index
order by person_id 

select 
   person_id
, '0' as IP_visit_count_1yr
INTO #NO_IP_visit_1yr
from #visit_types a
where person_id NOT IN (select distinct person_id from #IP_visit_1yr)


 select *
 INTO #ingested_IP_visit_1yr
 from #IP_visit_1yr
 UNION 
 select * 
 from #NO_IP_visit_1yr
 ORDER BY person_id



   ---appending to main table 
  select 
   a.*
 , b.IP_visit_count_1yr
 INTO #IP_visit_1yr_done
 from #CT a 
 JOIN #ingested_IP_visit_1yr b ON a.person_id=b.person_id 
 order by a.person_id 



  ----------------------------
 ---IP visit field 2 year
 ---------------------------
select 
person_id
, visit_type_count as IP_visit_count_2yr
INTO #IP_visit_2yr
from #visit_type_count_pp a
where visit_concept_id = 9201 --Inpatient 
		AND year_of_visit = 'within second year from index' --encounter was within 1yr from index
order by person_id 

select 
person_id
, '0' as IP_visit_count_2yr
INTO #NO_IP_visit_2yr
from #visit_types a
where person_id NOT IN (select distinct person_id from #IP_visit_2yr)


 select *
 INTO #ingested_IP_visit_2yr
 from #IP_visit_2yr
 UNION 
 select * 
 from #NO_IP_visit_2yr
 ORDER BY person_id

 

   ---appending to main table 
  select 
   a.*
 , b.IP_visit_count_2yr
 INTO #IP_visit_2yr_done
 from #IP_visit_1yr_done a 
 JOIN #ingested_IP_visit_2yr b ON a.person_id=b.person_id 
 order by a.person_id 

 

 -----------------------------
 ----OP visit field 1 yr--
 ----------------------------
 select 
  person_id
, sum(visit_type_count) as OP_visit_count_1yr --the sum is needed because there are multiple visit types (unlike IP)
INTO #OP_visit_1yr
from #visit_type_count_pp a
where visit_concept_id in (9202, 581477, 8756) --outpatient visits and outpatient hospital 
	AND year_of_visit = 'within first year from index'
group by person_id
order by person_id 

select 
person_id
, '0' as OP_visit_count_1yr
INTO #NO_OP_visit_1yr
from #visit_types a
where person_id NOT IN (select distinct person_id from #OP_visit_1yr)


 select *
 INTO #ingested_OP_visit_1yr
 from #OP_visit_1yr
 UNION 
 select * 
 from #NO_OP_visit_1yr
 ORDER BY person_id


   ---appending to main table 
  select 
   a.*
 , b.OP_visit_count_1yr
 INTO #OP_visit_1yr_done
 from #IP_visit_2yr_done a 
 JOIN #ingested_OP_visit_1yr b ON a.person_id=b.person_id 
 order by a.person_id 



  -----------------------------
 ----OP visit field 2 yr---
 -----------------------------
 select 
  person_id
, sum(visit_type_count) as OP_visit_count_2yr --the sum is needed because there are multiple visit types (unlike IP)
INTO #OP_visit_2yr
from #visit_type_count_pp a
where visit_concept_id in (9202, 581477, 8756) --outpatient visits and outpatient hospital 
	AND year_of_visit = 'within second year from index'
group by person_id
order by person_id 

select 
person_id
, '0' as OP_visit_count_2yr
INTO #NO_OP_visit_2yr
from #visit_types a
where person_id NOT IN (select distinct person_id from #OP_visit_2yr)


 select *
 INTO #ingested_OP_visit_2yr
 from #OP_visit_2yr
 UNION 
 select * 
 from #NO_OP_visit_2yr
 ORDER BY person_id


   ---appending to main table 
  select 
   a.*
 , b.OP_visit_count_2yr
 INTO #OP_visit_2yr_done
 from #OP_visit_1yr_done a 
 JOIN #ingested_OP_visit_2yr b ON a.person_id=b.person_id 
 order by a.person_id;



   ----------------------------------
 ---non-gabapentinoid drug Rxs-----
 -----------------------------------

 --evaluate drug code set
-- select *
-- from concept c
-- where concept_id in (
-- select descendant_concept_id from @cdmDatabaseSchema.concept_ancestor where ancestor_concept_id in (
--  21604437
--, 19020002
--, 21604422
--, 745466
--, 742267
--, 715458
--, 35200286
--, 19006586
--, 751347
--, 740910
--, 734275
--, 42904177
--, 21604418
--, 759401
--, 702685
--, 711584
--, 705103
--, 19087394
--, 795661
--, 40239995
--, 21604398
--, 750119
--, 44507780
--, 40192657
--, 798874
--, 19050832
--, 37497998
--, 740275
--, 1510417
--, 35604901
--)
--)
--order by c.concept_name 

-- ---non gabapentinoids
--  select distinct
-- a.person_id
-- , de.drug_concept_id as non_gabapentinoid_concept_id
-- , c.concept_name as non_gabapentinoid_concept_name 
-- , de.drug_exposure_start_date as drug_rx_date 
-- , de.quantity
-- , de.refills
-- , de.days_supply
-- INTO #non_gabapentinoid_Rxs
-- from @workDatabaseSchema.newly_diagnosed_epilepsy_cohort a
-- JOIN @cdmDatabaseSchema.drug_exposure de ON a.person_id=de.person_id
-- JOIN @cdmDatabaseSchema.concept c ON de.drug_concept_id=c.concept_id
-- where de.drug_concept_id in (select descendant_concept_id from @cdmDatabaseSchema.concept_ancestor where ancestor_concept_id in (
--  21604437
--, 19020002
--, 21604422
--, 745466
--, 742267
--, 715458
--, 35200286
--, 19006586
--, 751347
--, 740910
--, 734275
--, 42904177
--, 21604418
--, 759401
--, 702685
--, 711584
--, 705103
--, 19087394
--, 795661
--, 40239995
--, 21604398
--, 750119
--, 44507780
--, 40192657
--, 798874
--, 19050832
--, 37497998
--, 740275
--, 1510417
--, 35604901
-- )
-- )
-- AND de.drug_exposure_start_date BETWEEN dateadd(YEAR, -20, a.start_date)  and dateadd(YEAR, 2, a.start_date)
-- --AND a.person_id NOT IN (select distinct person_id from #gabapentinoids_persons)
-- ORDER BY a.person_id, de.drug_exposure_start_date

-- select * ----of the duplicate drug records (two rows of same drug on same date), should we grab the one where visit occurrence id is not null? not sure how to think about the dups in this scenario  
-- from @cdmDatabaseSchema.drug_exposure 
-- where person_id = 15856 AND drug_exposure_start_date = "2015-03-24"
-- ORDER BY drug_concept_id


-- select distinct
--   person_id
-- , non_gabapentinoid_concept_id
-- , non_gabapentinoid_concept_name
-- , drug_rx_date
-- , refills
-- , quantity
-- , days_supply
-- into #non_gabapentinoid_Rxs_distinct 
-- from #non_gabapentinoid_Rxs
-- order by person_id, drug_rx_date


-- select *
-- from #non_gabapentinoid_Rxs_distinct
-- order by drug_rx_date desc 

-- select 
--   person_id
-- , count(*) as distinct_rxs
-- from #non_gabapentinoid_Rxs_distinct
-- group by person_id 
-- order by count(*) desc 


 ----skip non gaba drug prescriptions for now


 -----------------------
 ---MRI brain 2 years--- 
 -----------------------
  
  with mri as (
select 
  a.*
, po.procedure_concept_id as MRI_2year_concept_id
--, po.procedure_source_value as MRI_2year_CPT
,  c.concept_name as MRI_2year_concept
, po.procedure_date as MRI_2year_date 
, ROW_NUMBER() OVER (PARTITION BY a.person_id ORDER BY po.procedure_date) as mri_concept_count 
from #OP_visit_2yr_done a 
LEFT JOIN @cdmDatabaseSchema.procedure_occurrence po ON a.person_id=po.person_id
AND po.procedure_concept_id in 
(select descendant_concept_id from @cdmDatabaseSchema.concept_ancestor where ancestor_concept_id = 37311324) --MRI brain 
AND po.procedure_date BETWEEN dateadd(YEAR, -2, a.start_date)  and dateadd(YEAR, 2, a.start_date)
LEFT JOIN @cdmDatabaseSchema.concept c ON po.procedure_concept_id=c.concept_id
)
 select *
 into #mri
 from mri 
 where mri_concept_count = 1
 order by person_id;


 


 --------------------
 ---Any EEG 2 year--- (this is a different outcome from the DRE video EEG)
 --------------------
 
 with eeg as (
select 
  a.*
, po.procedure_concept_id as EEG_2year_concept_id
, po.procedure_source_value as EEG_2year_CPT
, c.concept_name as EEG_2year_concept
, po.procedure_date as EEG_2year_date 
, ROW_NUMBER() OVER (PARTITION BY a.person_id ORDER BY po.procedure_date) as eeg_concept_count 
from #mri a 
LEFT JOIN @cdmDatabaseSchema.procedure_occurrence po ON a.person_id=po.person_id
AND po.procedure_concept_id in (select descendant_concept_id from @cdmDatabaseSchema.concept_ancestor where ancestor_concept_id in (4181917)) --high level SNOMED concept for electro-encephalogram
AND po.procedure_date BETWEEN dateadd(YEAR, -2, a.start_date)  and dateadd(YEAR, 2, a.start_date)
LEFT JOIN @cdmDatabaseSchema.concept c ON po.procedure_concept_id=c.concept_id
)
  select *
 into #eeg
 from eeg 
 where eeg_concept_count = 1
 order by person_id;
 

 ------------------------------------------------
 ----DEMOGRAPHIC VARIABLES-----
 ------------------------------------------------
 select distinct 
 a.person_id 
, b.gender_concept_id
, ROUND(DATEDIFF(MONTH, b.birth_datetime, a.start_date)/12.0, 2) as Age
, b.race_source_value as Race
, b.ethnicity_source_value as Ethnicity
INTO #demo_variables
 from @workDatabaseSchema.newly_diagnosed_epilepsy_cohort a
 JOIN @cdmDatabaseSchema.person b ON a.person_id=b.person_id


 ---JOIN demo variables to main data set
select distinct 
  a.*
, b.gender_concept_id
, b.Age
, b.Race
, b.Ethnicity
INTO #demo_variables_done
from #eeg a
JOIN #demo_variables b ON a.person_id=b.person_id 

 --looking at main data set
 --select *
 --from #demo_variables_done
 --order by person_id 


 ----ADD observation time after index date
select distinct 
  a.person_id 
, MAX(b.visit_start_date) as max_visit_encounter_date
INTO #observation_time_post_index
from #demo_variables_done a
JOIN @cdmDatabaseSchema.visit_occurrence b ON a.person_id=b.person_id 
GROUP BY a.person_id
order by a.person_id 


---JOIN observation before index to main data set
select distinct 
  a.*
, b.max_visit_encounter_date as last_follow_up_date 
INTO #observation_time_done
from #demo_variables_done a
JOIN #observation_time_post_index b ON a.person_id=b.person_id 





 ----------------------------------
 ---Advanced Brain Imaging 2 year--- 
 ----------------------------------

--  ---yeses 
--select 
--  a.*
--, po.procedure_concept_id as Advanced_presurgery_2year_concept_id
--, po.procedure_source_value as Advanced_presurgery_2year_CPT
--,  c.concept_name as Advanced_presurgery_2year_concept
--, min(po.procedure_date) as Advanced_presurgery_2year_date 
--INTO #Advanced_presurgery_2year
--from @workDatabaseSchema.newly_diagnosed_epilepsy_cohort a 
--JOIN @cdmDatabaseSchema.procedure_occurrence po ON a.person_id=po.person_id
--JOIN @cdmDatabaseSchema.concept c ON po.procedure_concept_id=c.concept_id
--where (
--po.procedure_concept_id in (select descendant_concept_id from @cdmDatabaseSchema.concept_ancestor where ancestor_concept_id in (
--  2314156
----, 3138825 --this is non-standard; pasting in below the standard mapping
--, 35608075	
----, 4083104 --deprecated; also maps to 35608075
--, 2211355
--, 2211354
----, 2212017 --deprecated; pasting in below the standard mapping
--, 36713060
--, 2212018)) 
--) 
--AND po.procedure_date BETWEEN dateadd(YEAR, -2, a.start_date)  and dateadd(YEAR, 2, a.start_date)
--group by 
--a.person_id
--, a.start_date
--, a.end_date
--, po.procedure_concept_id
--, po.procedure_source_value
--, c.concept_name 
 
-- ---nos
-- select 
-- a.*
--, 0 as Advanced_presurgery_2year_concept_id
--, 'NULL' as Advanced_presurgery_2year_CPT
--, 'NULL' as Advanced_presurgery_2year_concept
--, '2099/01/01' as Video_EEG_2year_date  
--INTO #No_Advanced_presurgery_2year
-- from @workDatabaseSchema.newly_diagnosed_epilepsy_cohort a 
-- where person_id NOT IN (select distinct person_id from #Advanced_presurgery_2year)

--   ---combining both sets of folks 
-- select *
-- INTO #ingested_Advanced_presurgery_2year
-- from #Advanced_presurgery_2year
-- UNION 
-- select * 
-- from #No_Advanced_presurgery_2year
-- ORDER BY person_id

-- ---appending to main table 
--  select 
--   a.*
-- , b.Advanced_presurgery_2year_concept_id
-- , b.Advanced_presurgery_2year_CPT
-- , b.Advanced_presurgery_2year_concept
-- , b.Advanced_presurgery_2year_date
-- INTO #Advanced_presurgery_2year_done
-- from #EEG_2year_done a 
-- JOIN #ingested_Advanced_presurgery_2year b ON a.person_id=b.person_id 
-- order by a.person_id 

-- --looking at main data set
-- select * from #Advanced_presurgery_2year_done order by person_id 

 


 ----------------------------
 ---Neuropsych eval 2 year---
 ----------------------------

--  ---yeses  
--select 
--  a.*
--, po.procedure_concept_id as Neuropysch_2year_concept_id
--, po.procedure_source_value as Neuropysch_2year_CPT
--, c.concept_name as Neuropysch_2year_concept
--, min(po.procedure_date) as Neuropysch_2year_date 
--INTO #Neuropysch_2year
--from @workDatabaseSchema.newly_diagnosed_epilepsy_cohort a 
--JOIN @cdmDatabaseSchema.procedure_occurrence po ON a.person_id=po.person_id
--JOIN @cdmDatabaseSchema.concept c ON po.procedure_concept_id=c.concept_id
--where (
--po.procedure_concept_id in (select descendant_concept_id from @cdmDatabaseSchema.concept_ancestor where ancestor_concept_id in (
--  2314185
--, 927174
--, 927175
--, 2007705
--, 2007690
--, 2007704
--, 927172
--, 927173
--, 2314196
--, 2314195
--, 2314194
--, 2314192	
--, 2314189
--, 2007703
--, 2007702
--, 2007691
--)) 
--) 
--AND po.procedure_date BETWEEN dateadd(YEAR, -2, a.start_date)  and dateadd(YEAR, 2, a.start_date)
--group by 
--a.person_id
--, a.start_date
--, a.end_date
--, po.procedure_concept_id
--, po.procedure_source_value
--, c.concept_name 
 
-- ---nos
-- select 
-- a.*
--, 0 as Neuropysch_2year_concept_id
--, 'NULL' as Neuropysch_2year_CPT
--, 'NULL' as Neuropysch_2year_concept
--, '2099/01/01' as Neuropysch_2year_date  
--INTO #No_Neuropysch_2year
-- from @workDatabaseSchema.newly_diagnosed_epilepsy_cohort a 
-- where person_id NOT IN (select distinct person_id from #Neuropysch_2year)

--   ---combining both sets of folks 
-- select *
-- INTO #ingested_Neuropysch_2year
-- from #Neuropysch_2year
-- UNION 
-- select * 
-- from #No_Neuropysch_2year
-- ORDER BY person_id

-- ---appending to main table 
--  select 
--   a.*
-- , b.Neuropysch_2year_concept_id
-- , b.Neuropysch_2year_CPT
-- , b.Neuropysch_2year_concept
-- , b.Neuropysch_2year_date
-- INTO #Neuropysch_2year_done
-- from #Advanced_presurgery_2year_done a 
-- JOIN #ingested_Neuropysch_2year b ON a.person_id=b.person_id 
-- order by a.person_id 

-- --looking at main data set
-- select * from #Neuropysch_2year_done order by person_id 

 


------------------------------
 ---Epilepsy surgery 2 year---
------------------------------

--  ---yeses  
--select 
--  a.*
--, po.procedure_concept_id as epilepsy_surgery_2year_concept_id
--, po.procedure_source_value as epilepsy_surgery_2year_CPT
--, c.concept_name as epilepsy_surgery_2year_concept
--, min(po.procedure_date) as epilepsy_surgery_2year_date 
--INTO #epilepsy_surgery_2year
--from @workDatabaseSchema.newly_diagnosed_epilepsy_cohort a 
--JOIN @cdmDatabaseSchema.procedure_occurrence po ON a.person_id=po.person_id
--JOIN @cdmDatabaseSchema.concept c ON po.procedure_concept_id=c.concept_id
--where (
--po.procedure_concept_id in (select descendant_concept_id from @cdmDatabaseSchema.concept_ancestor where ancestor_concept_id in (
--  2110457
--, 2110458
--, 40479988
--, ​​2110543
--, 40479650
--, 3655808
--, 2000126
--, 4200691
--, 4232246
--, 4218537
--, 2110459
--, 2110462
--, 2110463
--, 2110464
--, 2110465
--, 2110481
--, 2110482
--, 2110466
--, 2000125
--, 36905041
--, 2722695
--, 2110468
--, 4031033
--, 42873047
--, 2000236
--, 40757131
--, 42734019
--, 4262290
--, 2110554
--, 2110555
--, 2110557
--, 2110558
--, 2110559
--, 2110560
--, 40756794
--, 2000158
--, 2723316
--, 2723319
--, 2723322
--, 608574
--, 1389720
--, 1389721
--, 40756779
--, 2791323
--, 2791327
--)) 
--) 
--AND po.procedure_date BETWEEN dateadd(YEAR, -2, a.start_date)  and dateadd(YEAR, 2, a.start_date)
--group by 
--a.person_id
--, a.start_date
--, a.end_date
--, po.procedure_concept_id
--, po.procedure_source_value 
--, c.concept_name 
 
-- ---nos
-- select 
-- a.*
--, 0 as epilepsy_surgery_2year_concept_id
--, 'NULL' as epilepsy_surgery_2year_CPT
--, 'NULL' as epilepsy_surgery_2year_concept
--, '2099/01/01' as epilepsy_surgery_2year_date  
--INTO #No_epilepsy_surgery_2year
-- from @workDatabaseSchema.newly_diagnosed_epilepsy_cohort a 
-- where person_id NOT IN (select distinct person_id from #epilepsy_surgery_2year)

--   ---combining both sets of folks 
-- select *
-- INTO #ingested_epilepsy_surgery_2year
-- from #epilepsy_surgery_2year
-- UNION 
-- select * 
-- from #No_epilepsy_surgery_2year
-- ORDER BY person_id

-- ---appending to main table 
--  select 
--   a.*
-- , b.epilepsy_surgery_2year_concept_id
-- , b.epilepsy_surgery_2year_CPT
-- , b.epilepsy_surgery_2year_concept
-- , b.epilepsy_surgery_2year_date
-- INTO #epilepsy_surgery_2year_done
-- from #Neuropysch_2year_done a 
-- JOIN #ingested_epilepsy_surgery_2year b ON a.person_id=b.person_id 
-- order by a.person_id 

-- --looking at main data set
-- select * from #epilepsy_surgery_2year_done order by person_id 


 


-----------------------------------------------------------
-------Composite Outcome (comprehensive evaluation) -------
-----------------------------------------------------------

----having >= 1 Video EEG AND having >= 1 neuropsychological evaluation AND (MRI brain OR advanced brain imaging)

--select distinct
--person_id
--, Video_EEG_2year_CPT
--, Video_EEG_2year_date
--, Advanced_presurgery_2year_CPT
--, Advanced_presurgery_2year_date
--, MRI_2year_CPT
--, MRI_2year_date
--, Neuropysch_2year_CPT
--, Neuropysch_2year_date
--, case 
--  when (Video_EEG_2year_concept != 'NULL' AND Neuropysch_2year_concept != 'NULL' AND (Advanced_presurgery_2year_concept != 'NULL' OR MRI_2year_concept != NULL)) THEN 1
--  else 0
--  end as comprehensive_outcome 
--  INTO #comprehensive 
--from #epilepsy_surgery_2year_done
--order by person_id

-- ---appending to main table 
--  select 
--   a.*
-- , b.comprehensive_outcome 
-- INTO #comprehensive_outcome_done 
-- from #epilepsy_surgery_2year_done a 
-- JOIN #comprehensive b ON a.person_id=b.person_id 
-- order by a.person_id 

-- select * from #comprehensive_outcome_done order by person_id 

----produce distinct rows in final data set
select *
INTO #NDE_cohort_done
from #observation_time_done
UNION
select *
from #observation_time_done

select * from #NDE_cohort_done order by person_id 

 ---if permanent table already exists
 IF OBJECT_ID('@workDatabaseSchema.newly_diagnosed_epilepsy_cohort_with_covariates', 'U') IS NOT NULL 
  DROP TABLE @workDatabaseSchema.newly_diagnosed_epilepsy_cohort_with_covariates; 

---store NDE cohort done temp table as permanent table
select * 
INTO @workDatabaseSchema.newly_diagnosed_epilepsy_cohort_with_covariates
from #NDE_cohort_done



 













