CREATE TABLE @temp_database_schema.ujomo9i2Codesets  
USING DELTA
 AS
SELECT
CAST(NULL AS int) AS codeset_id,
	CAST(NULL AS bigint) AS concept_id  WHERE 1 = 0;
INSERT INTO @temp_database_schema.ujomo9i2Codesets (codeset_id, concept_id)
SELECT 0 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (380378,377091)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (380378,377091)
 and c.invalid_reason is null
) I
LEFT JOIN
(
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (444413,377101)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (444413,377101)
 and c.invalid_reason is null
) E ON I.concept_id = E.concept_id
WHERE E.concept_id is null
) C UNION ALL 
SELECT 1 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (380378,377091)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (380378,377091)
 and c.invalid_reason is null
) I
LEFT JOIN
(
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (444413,377101)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (444413,377101)
 and c.invalid_reason is null
) E ON I.concept_id = E.concept_id
WHERE E.concept_id is null
) C UNION ALL 
SELECT 2 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (740275,790253,40192657,21604398,795661,713192,705103,711584,702685,759401,21604418,740910,751347,715458,742267,745466,21604422,21604437)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (740275,790253,40192657,21604398,795661,713192,705103,711584,702685,759401,21604418,740910,751347,715458,742267,745466,21604422,21604437)
 and c.invalid_reason is null
) I
) C UNION ALL 
SELECT 3 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (380378,377091)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (380378,377091)
 and c.invalid_reason is null
) I
LEFT JOIN
(
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (444413,44783583,377101)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (444413,44783583,377101)
 and c.invalid_reason is null
) E ON I.concept_id = E.concept_id
WHERE E.concept_id is null
) C UNION ALL 
SELECT 4 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (380378,377091)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (380378,377091)
 and c.invalid_reason is null
) I
LEFT JOIN
(
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (444413,44783583,377101)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (444413,44783583,377101)
 and c.invalid_reason is null
) E ON I.concept_id = E.concept_id
WHERE E.concept_id is null
) C UNION ALL 
SELECT 5 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (380378,377091)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (380378,377091)
 and c.invalid_reason is null
) I
LEFT JOIN
(
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (444413,44783583,377101)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (444413,44783583,377101)
 and c.invalid_reason is null
) E ON I.concept_id = E.concept_id
WHERE E.concept_id is null
) C UNION ALL 
SELECT 6 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (380378,377091)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (380378,377091)
 and c.invalid_reason is null
) I
LEFT JOIN
(
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (444413,44783583,377101)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (444413,44783583,377101)
 and c.invalid_reason is null
) E ON I.concept_id = E.concept_id
WHERE E.concept_id is null
) C UNION ALL 
SELECT 7 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (740275,790253,40192657,21604398,795661,713192,705103,711584,702685,759401,21604418,740910,734354,751347,715458,742267,745466,21604422,21604437)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (740275,790253,40192657,21604398,795661,713192,705103,711584,702685,759401,21604418,740910,734354,751347,715458,742267,745466,21604422,21604437)
 and c.invalid_reason is null
) I
) C UNION ALL 
SELECT 8 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (380378)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (380378)
 and c.invalid_reason is null
) I
LEFT JOIN
(
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (444413,44783583,377101)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (444413,44783583,377101)
 and c.invalid_reason is null
) E ON I.concept_id = E.concept_id
WHERE E.concept_id is null
) C UNION ALL 
SELECT 9 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (4236312,380378,43531630,4029498)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (380378)
 and c.invalid_reason is null
) I
LEFT JOIN
(
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (45757050,444413,44783583,46270370,377101)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (45757050,444413,44783583,46270370,377101)
 and c.invalid_reason is null
) E ON I.concept_id = E.concept_id
WHERE E.concept_id is null
) C UNION ALL 
SELECT 10 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (4236312,380378,43531630,4029498)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (380378)
 and c.invalid_reason is null
) I
LEFT JOIN
(
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (45757050,444413,44783583,46270370,377101)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (45757050,444413,44783583,46270370,377101)
 and c.invalid_reason is null
) E ON I.concept_id = E.concept_id
WHERE E.concept_id is null
) C UNION ALL 
SELECT 11 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (740275,790253,40192657,21604398,795661,705103,711584,702685,759401,21604418,740910,734354,751347,715458,742267,745466,21604422,21604437,19050832,19087394,35604901,1510417,37497998,37497998,44507780,750119,40239995,797399,42904177,734275,35200286,19006586,19020002,798874)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (740275,790253,40192657,21604398,795661,705103,711584,702685,759401,21604418,740910,734354,751347,715458,742267,745466,21604422,21604437,19050832,19087394,35604901,1510417,37497998,37497998,44507780,750119,40239995,797399,42904177,734275,35200286,19006586,19020002,798874)
 and c.invalid_reason is null
) I
LEFT JOIN
(
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (713192)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (713192)
 and c.invalid_reason is null
) E ON I.concept_id = E.concept_id
WHERE E.concept_id is null
) C UNION ALL 
SELECT 12 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (740275,40192657,21604398,795661,705103,711584,702685,759401,21604418,740910,734354,751347,715458,742267,745466,21604422,21604437,19050832,19087394,35604901,1510417,37497998,37497998,44507780,750119,40239995,797399,42904177,734275,35200286,19006586,19020002,798874)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (740275,40192657,21604398,795661,705103,711584,702685,759401,21604418,740910,734354,751347,715458,742267,745466,21604422,21604437,19050832,19087394,35604901,1510417,37497998,37497998,44507780,750119,40239995,797399,42904177,734275,35200286,19006586,19020002,798874)
 and c.invalid_reason is null
) I
LEFT JOIN
(
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (790253,713192)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (790253,713192)
 and c.invalid_reason is null
) E ON I.concept_id = E.concept_id
WHERE E.concept_id is null
) C UNION ALL 
SELECT 13 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (380378,44783583)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (380378,44783583)
 and c.invalid_reason is null
) I
LEFT JOIN
(
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (444413,377101)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (444413,377101)
 and c.invalid_reason is null
) E ON I.concept_id = E.concept_id
WHERE E.concept_id is null
) C UNION ALL 
SELECT 14 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (380378,44783583,377091)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (380378,44783583,377091)
 and c.invalid_reason is null
) I
LEFT JOIN
(
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (444413,377101)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (444413,377101)
 and c.invalid_reason is null
) E ON I.concept_id = E.concept_id
WHERE E.concept_id is null
) C UNION ALL 
SELECT 15 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (40483317,4309257)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (40483317,4309257)
 and c.invalid_reason is null
) I
) C UNION ALL 
SELECT 16 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (2211351)
) I
) C UNION ALL 
SELECT 17 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (442077)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (442077)
 and c.invalid_reason is null
) I
) C UNION ALL 
SELECT 18 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (4125350)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (4125350)
 and c.invalid_reason is null
) I
) C UNION ALL 
SELECT 19 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (37311324)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (37311324)
 and c.invalid_reason is null
) I
) C UNION ALL 
SELECT 20 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (2212018,4083104,3138825,2212017,2211354,2211355,2314156,4083104)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (2212018,4083104,3138825,2212017,2211354,2211355,2314156,4083104)
 and c.invalid_reason is null
) I
LEFT JOIN
(
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (3138825)
) E ON I.concept_id = E.concept_id
WHERE E.concept_id is null
) C UNION ALL 
SELECT 21 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (4102081,2314150,2007015)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (4102081)
 and c.invalid_reason is null
) I
) C UNION ALL 
SELECT 22 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (927172,927173,2314185,2314189,2314195,2314194,2314192,2314196,2007691,2007702,2007703,2007704,2007690,2007705,927174,927175)
) I
) C UNION ALL 
SELECT 23 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (8870,262,9203)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (8870,262,9203)
 and c.invalid_reason is null
) I
) C UNION ALL 
SELECT 24 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (262,9201)
) I
) C UNION ALL 
SELECT 25 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (8756,9202)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (8756,9202)
 and c.invalid_reason is null
) I
) C UNION ALL 
SELECT 26 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (380378,377091)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (380378,377091)
 and c.invalid_reason is null
) I
) C UNION ALL 
SELECT 27 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (380378)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (380378)
 and c.invalid_reason is null
) I
) C UNION ALL 
SELECT 28 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (380378)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (380378)
 and c.invalid_reason is null
) I
) C UNION ALL 
SELECT 29 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
 select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (380378)
UNION select c.concept_id
 from @vocabulary_database_schema.CONCEPT c
 join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
 and ca.ancestor_concept_id in (380378)
 and c.invalid_reason is null
) I
) C;
CREATE TABLE @temp_database_schema.ujomo9i2qualified_events
USING DELTA
AS
SELECT
event_id, person_id, start_date, end_date, op_start_date, op_end_date, visit_occurrence_id
FROM
(
 select pe.event_id, pe.person_id, pe.start_date, pe.end_date, pe.op_start_date, pe.op_end_date, row_number() over (partition by pe.person_id order by pe.start_date ASC) as ordinal, cast(pe.visit_occurrence_id as bigint) as visit_occurrence_id
 FROM (-- Begin Primary Events
select P.ordinal as event_id, P.person_id, P.start_date, P.end_date, op_start_date, op_end_date, cast(P.visit_occurrence_id as bigint) as visit_occurrence_id
FROM
(
 select E.person_id, E.start_date, E.end_date,
 row_number() OVER (PARTITION BY E.person_id ORDER BY E.sort_date ASC, E.event_id) ordinal,
 OP.observation_period_start_date as op_start_date, OP.observation_period_end_date as op_end_date, cast(E.visit_occurrence_id as bigint) as visit_occurrence_id
 FROM 
 (
 -- Begin Condition Occurrence Criteria
SELECT C.person_id, C.condition_occurrence_id as event_id, C.start_date, C.end_date,
 C.visit_occurrence_id, C.start_date as sort_date
FROM 
(
 SELECT co.person_id,co.condition_occurrence_id,co.condition_concept_id,co.visit_occurrence_id,co.condition_start_date as start_date, COALESCE(co.condition_end_date, date_add(co.condition_start_date, 1)) as end_date , row_number() over (PARTITION BY co.person_id ORDER BY co.condition_start_date, co.condition_occurrence_id) as ordinal
 FROM @cdm_database_schema.CONDITION_OCCURRENCE co
 JOIN @temp_database_schema.ujomo9i2Codesets cs on (co.condition_concept_id = cs.concept_id and cs.codeset_id = 27)
) C
JOIN @cdm_database_schema.VISIT_OCCURRENCE V on C.visit_occurrence_id = V.visit_occurrence_id and C.person_id = V.person_id
WHERE (C.start_date >= to_date(cast(2010 as string) || '-' || cast(1 as string) || '-' || cast(1 as string)) and C.start_date <= to_date(cast(2024 as string) || '-' || cast(1 as string) || '-' || cast(1 as string)))
AND V.visit_concept_id in (262,9201,9203)
AND C.ordinal = 1
-- End Condition Occurrence Criteria
UNION ALL
select PE.person_id, PE.event_id, PE.start_date, PE.end_date, PE.visit_occurrence_id, PE.sort_date FROM (
-- Begin Condition Occurrence Criteria
SELECT C.person_id, C.condition_occurrence_id as event_id, C.start_date, C.end_date,
 C.visit_occurrence_id, C.start_date as sort_date
FROM 
(
 SELECT co.person_id,co.condition_occurrence_id,co.condition_concept_id,co.visit_occurrence_id,co.condition_start_date as start_date, COALESCE(co.condition_end_date, date_add(co.condition_start_date, 1)) as end_date 
 FROM @cdm_database_schema.CONDITION_OCCURRENCE co
 JOIN @temp_database_schema.ujomo9i2Codesets cs on (co.condition_concept_id = cs.concept_id and cs.codeset_id = 28)
) C
JOIN @cdm_database_schema.VISIT_OCCURRENCE V on C.visit_occurrence_id = V.visit_occurrence_id and C.person_id = V.person_id
WHERE (C.start_date >= to_date(cast(2010 as string) || '-' || cast(1 as string) || '-' || cast(1 as string)) and C.start_date <= to_date(cast(2024 as string) || '-' || cast(1 as string) || '-' || cast(1 as string)))
AND V.visit_concept_id in (9202)
-- End Condition Occurrence Criteria
) PE
JOIN (
-- Begin Criteria Group
select 0 as index_id, person_id, event_id
FROM
(
 select E.person_id, E.event_id 
 FROM (SELECT Q.person_id, Q.event_id, Q.start_date, Q.end_date, Q.visit_occurrence_id, OP.observation_period_start_date as op_start_date, OP.observation_period_end_date as op_end_date
FROM (-- Begin Condition Occurrence Criteria
SELECT C.person_id, C.condition_occurrence_id as event_id, C.start_date, C.end_date,
 C.visit_occurrence_id, C.start_date as sort_date
FROM 
(
 SELECT co.person_id,co.condition_occurrence_id,co.condition_concept_id,co.visit_occurrence_id,co.condition_start_date as start_date, COALESCE(co.condition_end_date, date_add(co.condition_start_date, 1)) as end_date 
 FROM @cdm_database_schema.CONDITION_OCCURRENCE co
 JOIN @temp_database_schema.ujomo9i2Codesets cs on (co.condition_concept_id = cs.concept_id and cs.codeset_id = 28)
) C
JOIN @cdm_database_schema.VISIT_OCCURRENCE V on C.visit_occurrence_id = V.visit_occurrence_id and C.person_id = V.person_id
WHERE (C.start_date >= to_date(cast(2010 as string) || '-' || cast(1 as string) || '-' || cast(1 as string)) and C.start_date <= to_date(cast(2024 as string) || '-' || cast(1 as string) || '-' || cast(1 as string)))
AND V.visit_concept_id in (9202)
-- End Condition Occurrence Criteria
) Q
JOIN @cdm_database_schema.OBSERVATION_PERIOD OP on Q.person_id = OP.person_id 
 and OP.observation_period_start_date <= Q.start_date and OP.observation_period_end_date >= Q.start_date
) E
 INNER JOIN
 (
 -- Begin Correlated Criteria
select 0 as index_id, cc.person_id, cc.event_id
from (SELECT p.person_id, p.event_id 
FROM (SELECT Q.person_id, Q.event_id, Q.start_date, Q.end_date, Q.visit_occurrence_id, OP.observation_period_start_date as op_start_date, OP.observation_period_end_date as op_end_date
FROM (-- Begin Condition Occurrence Criteria
SELECT C.person_id, C.condition_occurrence_id as event_id, C.start_date, C.end_date,
 C.visit_occurrence_id, C.start_date as sort_date
FROM 
(
 SELECT co.person_id,co.condition_occurrence_id,co.condition_concept_id,co.visit_occurrence_id,co.condition_start_date as start_date, COALESCE(co.condition_end_date, date_add(co.condition_start_date, 1)) as end_date 
 FROM @cdm_database_schema.CONDITION_OCCURRENCE co
 JOIN @temp_database_schema.ujomo9i2Codesets cs on (co.condition_concept_id = cs.concept_id and cs.codeset_id = 28)
) C
JOIN @cdm_database_schema.VISIT_OCCURRENCE V on C.visit_occurrence_id = V.visit_occurrence_id and C.person_id = V.person_id
WHERE (C.start_date >= to_date(cast(2010 as string) || '-' || cast(1 as string) || '-' || cast(1 as string)) and C.start_date <= to_date(cast(2024 as string) || '-' || cast(1 as string) || '-' || cast(1 as string)))
AND V.visit_concept_id in (9202)
-- End Condition Occurrence Criteria
) Q
JOIN @cdm_database_schema.OBSERVATION_PERIOD OP on Q.person_id = OP.person_id 
 and OP.observation_period_start_date <= Q.start_date and OP.observation_period_end_date >= Q.start_date
) P
JOIN (
 -- Begin Condition Occurrence Criteria
SELECT C.person_id, C.condition_occurrence_id as event_id, C.start_date, C.end_date,
 C.visit_occurrence_id, C.start_date as sort_date
FROM 
(
 SELECT co.person_id,co.condition_occurrence_id,co.condition_concept_id,co.visit_occurrence_id,co.condition_start_date as start_date, COALESCE(co.condition_end_date, date_add(co.condition_start_date, 1)) as end_date 
 FROM @cdm_database_schema.CONDITION_OCCURRENCE co
 JOIN @temp_database_schema.ujomo9i2Codesets cs on (co.condition_concept_id = cs.concept_id and cs.codeset_id = 29)
) C
JOIN @cdm_database_schema.VISIT_OCCURRENCE V on C.visit_occurrence_id = V.visit_occurrence_id and C.person_id = V.person_id
WHERE V.visit_concept_id in (9202)
-- End Condition Occurrence Criteria
) A on A.person_id = P.person_id AND A.START_DATE >= P.OP_START_DATE AND A.START_DATE <= P.OP_END_DATE AND A.START_DATE >= date_add(P.START_DATE, -730) AND A.START_DATE <= date_add(P.START_DATE, -30) ) cc 
GROUP BY cc.person_id, cc.event_id
HAVING COUNT(cc.event_id) >= 1
-- End Correlated Criteria
 ) CQ on E.person_id = CQ.person_id and E.event_id = CQ.event_id
 GROUP BY E.person_id, E.event_id
 HAVING COUNT(index_id) = 1
) G
-- End Criteria Group
) AC on AC.person_id = pe.person_id and AC.event_id = pe.event_id
UNION ALL
select PE.person_id, PE.event_id, PE.start_date, PE.end_date, PE.visit_occurrence_id, PE.sort_date FROM (
-- Begin Drug Exposure Criteria
select C.person_id, C.drug_exposure_id as event_id, C.start_date, C.end_date,
 C.visit_occurrence_id,C.start_date as sort_date
from 
(
 select de.person_id,de.drug_exposure_id,de.drug_concept_id,de.visit_occurrence_id,days_supply,quantity,refills,de.drug_exposure_start_date as start_date, COALESCE(de.drug_exposure_end_date, date_add(de.drug_exposure_start_date, de.days_supply), date_add(de.drug_exposure_start_date, 1)) as end_date , row_number() over (PARTITION BY de.person_id ORDER BY de.drug_exposure_start_date, de.drug_exposure_id) as ordinal
 FROM @cdm_database_schema.DRUG_EXPOSURE de
JOIN @temp_database_schema.ujomo9i2Codesets cs on (de.drug_concept_id = cs.concept_id and cs.codeset_id = 12)
) C
WHERE (C.start_date >= to_date(cast(2010 as string) || '-' || cast(1 as string) || '-' || cast(1 as string)) and C.start_date <= to_date(cast(2024 as string) || '-' || cast(1 as string) || '-' || cast(1 as string)))
AND C.ordinal = 1
-- End Drug Exposure Criteria
) PE
JOIN (
-- Begin Criteria Group
select 0 as index_id, person_id, event_id
FROM
(
 select E.person_id, E.event_id 
 FROM (SELECT Q.person_id, Q.event_id, Q.start_date, Q.end_date, Q.visit_occurrence_id, OP.observation_period_start_date as op_start_date, OP.observation_period_end_date as op_end_date
FROM (-- Begin Drug Exposure Criteria
select C.person_id, C.drug_exposure_id as event_id, C.start_date, C.end_date,
 C.visit_occurrence_id,C.start_date as sort_date
from 
(
 select de.person_id,de.drug_exposure_id,de.drug_concept_id,de.visit_occurrence_id,days_supply,quantity,refills,de.drug_exposure_start_date as start_date, COALESCE(de.drug_exposure_end_date, date_add(de.drug_exposure_start_date, de.days_supply), date_add(de.drug_exposure_start_date, 1)) as end_date , row_number() over (PARTITION BY de.person_id ORDER BY de.drug_exposure_start_date, de.drug_exposure_id) as ordinal
 FROM @cdm_database_schema.DRUG_EXPOSURE de
JOIN @temp_database_schema.ujomo9i2Codesets cs on (de.drug_concept_id = cs.concept_id and cs.codeset_id = 12)
) C
WHERE (C.start_date >= to_date(cast(2010 as string) || '-' || cast(1 as string) || '-' || cast(1 as string)) and C.start_date <= to_date(cast(2024 as string) || '-' || cast(1 as string) || '-' || cast(1 as string)))
AND C.ordinal = 1
-- End Drug Exposure Criteria
) Q
JOIN @cdm_database_schema.OBSERVATION_PERIOD OP on Q.person_id = OP.person_id 
 and OP.observation_period_start_date <= Q.start_date and OP.observation_period_end_date >= Q.start_date
) E
 INNER JOIN
 (
 -- Begin Correlated Criteria
select 0 as index_id, cc.person_id, cc.event_id
from (SELECT p.person_id, p.event_id 
FROM (SELECT Q.person_id, Q.event_id, Q.start_date, Q.end_date, Q.visit_occurrence_id, OP.observation_period_start_date as op_start_date, OP.observation_period_end_date as op_end_date
FROM (-- Begin Drug Exposure Criteria
select C.person_id, C.drug_exposure_id as event_id, C.start_date, C.end_date,
 C.visit_occurrence_id,C.start_date as sort_date
from 
(
 select de.person_id,de.drug_exposure_id,de.drug_concept_id,de.visit_occurrence_id,days_supply,quantity,refills,de.drug_exposure_start_date as start_date, COALESCE(de.drug_exposure_end_date, date_add(de.drug_exposure_start_date, de.days_supply), date_add(de.drug_exposure_start_date, 1)) as end_date , row_number() over (PARTITION BY de.person_id ORDER BY de.drug_exposure_start_date, de.drug_exposure_id) as ordinal
 FROM @cdm_database_schema.DRUG_EXPOSURE de
JOIN @temp_database_schema.ujomo9i2Codesets cs on (de.drug_concept_id = cs.concept_id and cs.codeset_id = 12)
) C
WHERE (C.start_date >= to_date(cast(2010 as string) || '-' || cast(1 as string) || '-' || cast(1 as string)) and C.start_date <= to_date(cast(2024 as string) || '-' || cast(1 as string) || '-' || cast(1 as string)))
AND C.ordinal = 1
-- End Drug Exposure Criteria
) Q
JOIN @cdm_database_schema.OBSERVATION_PERIOD OP on Q.person_id = OP.person_id 
 and OP.observation_period_start_date <= Q.start_date and OP.observation_period_end_date >= Q.start_date
) P
JOIN (
 -- Begin Condition Occurrence Criteria
SELECT C.person_id, C.condition_occurrence_id as event_id, C.start_date, C.end_date,
 C.visit_occurrence_id, C.start_date as sort_date
FROM 
(
 SELECT co.person_id,co.condition_occurrence_id,co.condition_concept_id,co.visit_occurrence_id,co.condition_start_date as start_date, COALESCE(co.condition_end_date, date_add(co.condition_start_date, 1)) as end_date , row_number() over (PARTITION BY co.person_id ORDER BY co.condition_start_date, co.condition_occurrence_id) as ordinal
 FROM @cdm_database_schema.CONDITION_OCCURRENCE co
 JOIN @temp_database_schema.ujomo9i2Codesets cs on (co.condition_concept_id = cs.concept_id and cs.codeset_id = 26)
) C
WHERE C.ordinal = 1
-- End Condition Occurrence Criteria
) A on A.person_id = P.person_id AND A.START_DATE >= P.OP_START_DATE AND A.START_DATE <= P.OP_END_DATE AND A.START_DATE >= date_add(P.START_DATE, -730) AND A.START_DATE <= date_add(P.START_DATE, 0) ) cc 
GROUP BY cc.person_id, cc.event_id
HAVING COUNT(cc.event_id) >= 1
-- End Correlated Criteria
 ) CQ on E.person_id = CQ.person_id and E.event_id = CQ.event_id
 GROUP BY E.person_id, E.event_id
 HAVING COUNT(index_id) = 1
) G
-- End Criteria Group
) AC on AC.person_id = pe.person_id and AC.event_id = pe.event_id
 ) E
 JOIN @cdm_database_schema.observation_period OP on E.person_id = OP.person_id and E.start_date >= OP.observation_period_start_date and E.start_date <= op.observation_period_end_date
 WHERE date_add(OP.OBSERVATION_PERIOD_START_DATE, 365) <= E.START_DATE AND date_add(E.START_DATE, 0) <= OP.OBSERVATION_PERIOD_END_DATE
) P
WHERE P.ordinal = 1
-- End Primary Events
) pe
) QE
;
CREATE TABLE @temp_database_schema.ujomo9i2inclusion_events  
USING DELTA
 AS
SELECT
CAST(NULL AS bigint) AS inclusion_rule_id,
	CAST(NULL AS bigint) AS person_id,
	CAST(NULL AS bigint) AS event_id  WHERE 1 = 0;
CREATE TABLE @temp_database_schema.ujomo9i2included_events
USING DELTA
AS
SELECT
event_id, person_id, start_date, end_date, op_start_date, op_end_date
FROM
(
 SELECT event_id, person_id, start_date, end_date, op_start_date, op_end_date, row_number() over (partition by person_id order by start_date ASC) as ordinal
 from
 (
 select Q.event_id, Q.person_id, Q.start_date, Q.end_date, Q.op_start_date, Q.op_end_date, SUM(coalesce(POWER(cast(2 as bigint), I.inclusion_rule_id), 0)) as inclusion_rule_mask
 from @temp_database_schema.ujomo9i2qualified_events Q
 LEFT JOIN @temp_database_schema.ujomo9i2inclusion_events I on I.person_id = Q.person_id and I.event_id = Q.event_id
 GROUP BY Q.event_id, Q.person_id, Q.start_date, Q.end_date, Q.op_start_date, Q.op_end_date
 ) MG -- matching groups
) Results
;
CREATE TABLE @temp_database_schema.ujomo9i2cohort_rows
USING DELTA
AS
SELECT
person_id, start_date, end_date
FROM
( -- first_ends
 select F.person_id, F.start_date, F.end_date
 FROM (
 select I.event_id, I.person_id, I.start_date, CE.end_date, row_number() over (partition by I.person_id, I.event_id order by CE.end_date) as ordinal
 from @temp_database_schema.ujomo9i2included_events I
 join ( -- cohort_ends
-- cohort exit dates
-- By default, cohort exit at the event's op end date
select event_id, person_id, op_end_date as end_date from @temp_database_schema.ujomo9i2included_events
 ) CE on I.event_id = CE.event_id and I.person_id = CE.person_id and CE.end_date >= I.start_date
 ) F
 WHERE F.ordinal = 1
) FE;
CREATE TABLE @temp_database_schema.ujomo9i2final_cohort
USING DELTA
AS
SELECT
person_id, min(start_date) as start_date, end_date
FROM
( --cteEnds
 SELECT
 c.person_id
 , c.start_date
 , MIN(ed.end_date) AS end_date
 FROM @temp_database_schema.ujomo9i2cohort_rows c
 JOIN ( -- cteEndDates
 SELECT
 person_id
 , date_add(event_date, -1 * 0) as end_date
 FROM
 (
 SELECT
 person_id
 , event_date
 , event_type
 , SUM(event_type) OVER (PARTITION BY person_id ORDER BY event_date, event_type ROWS UNBOUNDED PRECEDING) AS interval_status
 FROM
 (
 SELECT
 person_id
 , start_date AS event_date
 , -1 AS event_type
 FROM @temp_database_schema.ujomo9i2cohort_rows
 UNION ALL
 SELECT
 person_id
 , date_add(end_date, 0) as end_date
 , 1 AS event_type
 FROM @temp_database_schema.ujomo9i2cohort_rows
 ) RAWDATA
 ) e
 WHERE interval_status = 0
 ) ed ON c.person_id = ed.person_id AND ed.end_date >= c.start_date
 GROUP BY c.person_id, c.start_date
) e
group by person_id, end_date
;
DELETE FROM @target_database_schema.@target_cohort_table where cohort_definition_id = @target_cohort_id;
INSERT INTO @target_database_schema.@target_cohort_table (cohort_definition_id, subject_id, cohort_start_date, cohort_end_date)
select @target_cohort_id as cohort_definition_id, person_id, start_date, end_date 
FROM @temp_database_schema.ujomo9i2final_cohort CO
;
TRUNCATE TABLE @temp_database_schema.ujomo9i2cohort_rows;
DROP TABLE @temp_database_schema.ujomo9i2cohort_rows;
TRUNCATE TABLE @temp_database_schema.ujomo9i2final_cohort;
DROP TABLE @temp_database_schema.ujomo9i2final_cohort;
TRUNCATE TABLE @temp_database_schema.ujomo9i2inclusion_events;
DROP TABLE @temp_database_schema.ujomo9i2inclusion_events;
TRUNCATE TABLE @temp_database_schema.ujomo9i2qualified_events;
DROP TABLE @temp_database_schema.ujomo9i2qualified_events;
TRUNCATE TABLE @temp_database_schema.ujomo9i2included_events;
DROP TABLE @temp_database_schema.ujomo9i2included_events;
TRUNCATE TABLE @temp_database_schema.ujomo9i2Codesets;
DROP TABLE @temp_database_schema.ujomo9i2Codesets;