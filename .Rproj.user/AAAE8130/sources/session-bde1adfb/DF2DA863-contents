## Newly Diagnosed Epilepsy Procedural Outcomes - OMOP Network Study ##

#install if not already installed
# install.packages("rlang")
# install.packages("vctrs")
# install.packages("pillar")
# install.packages("tibble")
# install.packages("dplyr")
# install.packages("tidyr")


# load needed R packages
library(DatabaseConnector)
library(SqlRender)
library(dplyr)
library(tibble)
library(tidyr)


# store Database details 
cdmDatabaseSchema <- "cdmDatabaseSchema"  # include both Db name and cdm schema name
workDatabaseSchema <- "workDatabaseSchema"   # include both Db name and results schema name
server <- 'server' # input your server name
dbms <- 'dbms' # input your sql dialect version
user <- 'user' # username used to connect
password <- 'password'# password used to connect 


# store connection details in connectionDetails object 
connectionDetails <- DatabaseConnector::createConnectionDetails(server = server
                                                                , dbms = dbms
                                                                , user = user
                                                                , password = password)
# Connect to your Database
conn <- DatabaseConnector::connect(connectionDetails)


### Step 1 of study -- Create cohort -- uncomment the sql dialect that corresponds to your DB

#sql1 <- SqlRender::readSql("Phenotype/Create cohort - sql server.sql")
#sql1 <- SqlRender::readSql("Phenotype/Create cohort - spark.sql")
sql1 <- SqlRender::render(sql1, 
                         cdmDatabaseSchema = cdmDatabaseSchema, 
                         workDatabaseSchema = workDatabaseSchema)
DatabaseConnector::executeSql(conn, sql1)

# Step 2 of study -- Create analytic data set -- uncomment sql dialect that corresponds to your DB

# sql2 <- SqlRender::readSql("Constructing Data Set/Adding study covariates - sql server.sql")
# sql2 <- SqlRender::readSql("Constructing Data Set/Adding study covariates - spark.sql")
sql2 <- SqlRender::render(sql2, 
                         cdmDatabaseSchema = cdmDatabaseSchema, 
                         workDatabaseSchema = workDatabaseSchema)
DatabaseConnector::executeSql(conn, sql2)


# Step 3 of study -- Import analytic data set -- no dialect selection should be needed 

sql3 <- SqlRender::readSql("Import/Import Data.sql")
sql3 <- SqlRender::render(sql3, workDatabaseSchema = workDatabaseSchema)

dataframe <- DatabaseConnector::querySql(conn, sql3)

# all column names to lower case
names(dataframe) <- tolower(names(dataframe))

# save all below output to a txt file called 'NDE analysis output' to this study directory
sink("NDE analysis output.txt", split = TRUE)


### Highlight the remainder of this script and execute ###
### Email the txt output file to tf2428@cumc.columbia.edu ###


# fixing dates
# dataframe <- dataframe %>%
#     mutate(
#         eeg_2year_date = as.Date(
#             as.numeric(ifelse(eeg_2year_date == "NULL", NA, eeg_2year_date)),
#             origin = "1899-12-30"
#         ),
#         mri_2year_date = as.Date(
#             as.numeric(ifelse(mri_2year_date == "NULL", NA, mri_2year_date)),
#             origin = "1899-12-30"
#         )
#     )


# Replace NA with 0 only for concept/count variables
concept_vars <- c(
    "brain_tumor_concept_id","gad_concept_id","lob_concept_id",
    "ts_concept_id","depression_concept_id","migraine_concept_id",
    "dementia_concept_id","tbi_concept_id","ct_concept_id",
    "generalized_epilepsy_concept_id","focal_epilepsy_concept_id",
    "mri_2year_concept_id","eeg_2year_concept_id"
)

dataframe <- dataframe %>%
    mutate(
        across(
            all_of(concept_vars),
            ~ as.integer(!is.na(.) & . != "NULL")
        )
    )




# ---- Derive age and create age groups ----
dataframe <- dataframe %>%
    mutate(
        age = floor(age),
        age_grp4 = cut(
            age,
            breaks = c(-Inf, 17, 39, 64, Inf),
            labels = c("0???17", "18???39", "40???64", "65+"),
            right = TRUE, include.lowest = TRUE
        )
    )


# ---- create gender/race/ethnicity labels based on concept IDs ---- 
dataframe <- dataframe %>%
    mutate(
        # gender stays from concept id
        gender = if_else(gender_concept_id == 8532, "female", "male"),
        
        # normalize Race strings -> analysis labels
        race = case_when(
            trimws(toupper(race)) == "WHITE"                          ~ "white",
            trimws(toupper(race)) == "ASIAN"                          ~ "asian",
            trimws(toupper(race)) == "BLACK OR AFRICAN AMERICAN"      ~ "black",
            trimws(toupper(race)) == "OTHER COMBINATIONS NOT DESCRIBED" ~ "other",
            TRUE                                                      ~ "not reported"
        ),
        
        # normalize Ethnicity strings -> analysis labels
        ethnicity = case_when(
            trimws(toupper(ethnicity)) == "NOT HISPANIC OR LATINO OR SPANISH ORIGIN" ~ "not hispanic or Latino",
            trimws(toupper(ethnicity)) == "HISPANIC OR LATINO OR SPANISH ORIGIN"     ~ "hispanic or Latino",
            trimws(toupper(ethnicity)) == "DECLINED"                                  ~ "not reported",
            TRUE                                                                      ~ "not reported"
        )
    )


# creating focal/generalized/mixed epilpsy variables
dataframe <- dataframe %>%
    mutate(
        # (re)derive Mixed epilepsy (neither focal nor generalized coded)
        mixed_epilepsy_dx = generalized_epilepsy_concept_id == 0 &
            focal_epilepsy_concept_id == 0,
        
        # derive 3-level epilepsy type
        epilepsy_type = case_when(
            generalized_epilepsy_concept_id != 0 ~ "Generalized",
            focal_epilepsy_concept_id != 0       ~ "Focal",
            mixed_epilepsy_dx                    ~ "Mixed",
            TRUE                                 ~ NA_character_
        ),
        
        # set factor levels + reference group
        epilepsy_type = relevel(
            factor(epilepsy_type, levels = c("Generalized", "Focal", "Mixed")),
            ref = "Generalized"
        )
    )


# ---- Derive observation time after index date ---- 
dataframe <- dataframe %>%
    mutate(
        obs_after_years =
            as.numeric(as.Date(last_follow_up_date) - as.Date(start_date)) / 365.25
    )



# ---- Re-leveling the variables to have correct ref group ---- 
dataframe <- dataframe %>%
    mutate(
        age_grp4  = factor(age_grp4, levels = c("0???17","18???39","40???64","65+")),  
        gender    = relevel(factor(gender), ref = "female"),
        race      = relevel(factor(race, levels = c("white","black","asian","other","not reported")), ref = "white"),
        ethnicity = relevel(factor(ethnicity, levels = c("not hispanic or Latino","hispanic or Latino","not reported")),
                            ref = "not hispanic or Latino")
    )









#------------------Outcomes-------------------------------------------------#

# ---- Derive 2 year non-emergency epilepsy visits outcome (???2 IP/OP) ----
dataframe <- dataframe %>%
    mutate(
        noned_visits = ip_visit_count_1yr + ip_visit_count_2yr +
            op_visit_count_1yr + op_visit_count_2yr,
        
        noned_epilepsy_visits = noned_visits >= 2
    )

# --- Derive 1 year non-emergency epilepsy visit outcome ---- #
dataframe <- dataframe %>%
    mutate(
        noned_visits_1yr = ip_visit_count_1yr + op_visit_count_1yr,
        
        noned_epilepsy_visits_1yr = noned_visits_1yr >= 2
    )

# ---- Derive composite outcome: MRI + EEG + ???2 non-ED epilepsy visits ----
dataframe <- dataframe %>%
    mutate(
        composite_complete_care_2y =
            mri_2year_concept_id != 0 &
            eeg_2year_concept_id != 0 &
            noned_epilepsy_visits == 1
    )




#____________________________Table 1_________________________________#
# categorical
cat_vars <- c("age_grp4", "gender", "race", "ethnicity", "epilepsy_type")

# binary (already 0/1)
bin_vars <- c(
    "brain_tumor_concept_id","gad_concept_id","lob_concept_id",
    "ts_concept_id","depression_concept_id","migraine_concept_id",
    "dementia_concept_id","tbi_concept_id","ct_concept_id"
)

cat_summary <- lapply(cat_vars, function(var) {
    dataframe %>%
        group_by(.data[[var]]) %>%
        summarise(
            n = n(),
            pct = 100 * n() / nrow(dataframe),
            .groups = "drop"
        ) %>%
        mutate(variable = var) %>%
        rename(level = .data[[var]])
}) %>%
    bind_rows()

cat_summary


#binary
bin_summary <- dataframe %>%
    summarise(across(
        all_of(bin_vars),
        ~ sum(. == 1, na.rm = TRUE)
    )) %>%
    pivot_longer(everything(), names_to = "variable", values_to = "n") %>%
    mutate(
        pct = 100 * n / nrow(dataframe)
    )

bin_summary


# continuous
cont_vars <- c("obs_after_years")
cont_summary <- dataframe %>%
    summarise(across(
        all_of(cont_vars),
        list(
            mean = ~ mean(., na.rm = TRUE),
            sd   = ~ sd(., na.rm = TRUE)
        )
    )) %>%
    pivot_longer(
        everything(),
        names_to = c("variable", ".value"),
        names_pattern = "^(.*)_(mean|sd)$"
    ) %>%
    mutate(
        level = "mean (SD)",
        value = sprintf("%.1f (%.1f)", mean, sd)
    ) %>%
    select(variable, level, value)

cont_summary

#all together
table1_summary <- bind_rows(
    cat_summary,
    bin_summary %>% mutate(level = "present") %>% select(variable, level, n, pct)
)

table1_summary







#________________________Counts for Figure 1/eTable 2_________________________________#


# ---- Clean date fields ----
dataframe <- dataframe %>%
    mutate(
        start_date     = as.Date(start_date),
        mri_2year_date = as.Date(mri_2year_date),
        eeg_2year_date = as.Date(eeg_2year_date),
        
        # Convert sentinel dates to NA
        mri_2year_date = if_else(mri_2year_date == as.Date("2099-01-01"), as.Date(NA), mri_2year_date),
        eeg_2year_date = if_else(eeg_2year_date == as.Date("2099-01-01"), as.Date(NA), eeg_2year_date)
    )

# ---- Derive MRI within ±1 year and ±2 years of index date ----
dataframe <- dataframe %>%
    mutate(
        mri_1year = mri_2year_concept_id != 0 &
            !is.na(mri_2year_date) &
            abs(as.integer(difftime(mri_2year_date, start_date, units = "days"))) <= 365,
        
        mri_2year = mri_2year_concept_id != 0 &
            !is.na(mri_2year_date) &
            abs(as.integer(difftime(mri_2year_date, start_date, units = "days"))) <= 730
    )

# ---- Derive EEG within ±1 year and ±2 years of index date ----
dataframe <- dataframe %>%
    mutate(
        eeg_1year = eeg_2year_concept_id != 0 &
            !is.na(eeg_2year_date) &
            abs(as.integer(difftime(eeg_2year_date, start_date, units = "days"))) <= 365,
        
        eeg_2year = eeg_2year_concept_id != 0 &
            !is.na(eeg_2year_date) &
            abs(as.integer(difftime(eeg_2year_date, start_date, units = "days"))) <= 730
    )

# ---- Derive true 1-year and 2-year composite outcomes ----
dataframe <- dataframe %>%
    mutate(
        composite_1year =
            mri_1year &
            eeg_1year &
            noned_epilepsy_visits_1yr,
        
        composite_2year =
            mri_2year &
            eeg_2year &
            noned_epilepsy_visits
    )





outcome_summary <- dataframe %>%
    summarise(
        N = n(),
        
        # ---- ±1-year outcomes ----
        mri_1year_n        = sum(mri_1year, na.rm = TRUE),
        mri_1year_prop     = mean(mri_1year, na.rm = TRUE),
        
        eeg_1year_n        = sum(eeg_1year, na.rm = TRUE),
        eeg_1year_prop     = mean(eeg_1year, na.rm = TRUE),
        
        noned_1year_n      = sum(noned_epilepsy_visits_1yr, na.rm = TRUE),
        noned_1year_prop   = mean(noned_epilepsy_visits_1yr, na.rm = TRUE),
        
        composite_1year_n    = sum(composite_1year, na.rm = TRUE),
        composite_1year_prop = mean(composite_1year, na.rm = TRUE),
        
        # ---- ±2-year outcomes ----
        mri_2year_n        = sum(mri_2year, na.rm = TRUE),
        mri_2year_prop     = mean(mri_2year, na.rm = TRUE),
        
        eeg_2year_n        = sum(eeg_2year, na.rm = TRUE),
        eeg_2year_prop     = mean(eeg_2year, na.rm = TRUE),
        
        noned_2year_n      = sum(noned_epilepsy_visits, na.rm = TRUE),
        noned_2year_prop   = mean(noned_epilepsy_visits, na.rm = TRUE),
        
        composite_2year_n    = sum(composite_2year, na.rm = TRUE),
        composite_2year_prop = mean(composite_2year, na.rm = TRUE)
    )

outcome_summary







#__________________________Univariate Analysis_____________________#

library(dplyr)
library(tidyr)
library(purrr)

#--------------------------------------------------
# 1) Make outcome binary 0/1
#--------------------------------------------------
dataframe <- dataframe %>%
    mutate(
        composite_2y = as.integer(composite_complete_care_2y != 0)
    )

#--------------------------------------------------
# 2) Convert relevant covariates to binary presence
#    (non-missing & != 0 -> 1; else 0)
#--------------------------------------------------
binary_covars <- c(
    "brain_tumor_concept_id",
    "gad_concept_id",
    "lob_concept_id",
    "ts_concept_id",
    "depression_concept_id",
    "migraine_concept_id",
    "dementia_concept_id",
    "tbi_concept_id",
    "ct_concept_id"
)

dataframe <- dataframe %>%
    mutate(
        across(all_of(binary_covars), ~ as.integer(!is.na(.) & . != 0))
    )

#--------------------------------------------------
# 3) Make categorical covariates factors
#--------------------------------------------------
categorical_covars <- c(
    "age_grp4",
    "gender",
    "race",
    "ethnicity",
    "epilepsy_type"
)

dataframe <- dataframe %>%
    mutate(
        across(all_of(categorical_covars), ~ as.factor(.))
    )

# Optional: set desired reference levels explicitly
# dataframe <- dataframe %>%
#   mutate(
#     age_grp4      = relevel(age_grp4, ref = "0-17"),
#     gender        = relevel(gender, ref = "female"),
#     race          = relevel(race, ref = "White"),
#     ethnicity     = relevel(ethnicity, ref = "Non-Hispanic"),
#     epilepsy_type = relevel(epilepsy_type, ref = "Generalized")
#   )

#--------------------------------------------------
# 4) Descriptive counts for binary covariates
#    overall + composite_2y == 1 only
#--------------------------------------------------
binary_summary <- map_dfr(binary_covars, function(var) {
    data.frame(
        covariate = var,
        level     = "Present",
        overall_n = sum(dataframe[[var]] == 1, na.rm = TRUE),
        comp1_n   = sum(dataframe[[var]] == 1 & dataframe$composite_2y == 1, na.rm = TRUE)
    )
})

#--------------------------------------------------
# 5) Univariate logistic regression for binary covariates
#--------------------------------------------------
run_uni_logistic_binary <- function(var, data, outcome = "composite_2y") {
    formula <- as.formula(paste(outcome, "~", var))
    fit <- glm(formula, data = data, family = binomial)
    co <- summary(fit)$coefficients
    
    data.frame(
        covariate = var,
        level     = "Present",
        OR        = exp(co[2, 1]),
        LCL       = exp(co[2, 1] - 1.96 * co[2, 2]),
        UCL       = exp(co[2, 1] + 1.96 * co[2, 2]),
        p         = co[2, 4],
        row.names = NULL
    )
}

binary_uni_results <- map_dfr(binary_covars, ~ run_uni_logistic_binary(.x, dataframe))

binary_final <- binary_summary %>%
    left_join(binary_uni_results, by = c("covariate", "level"))

#--------------------------------------------------
# 6) Descriptive counts for categorical covariates
#    overall + composite_2y == 1 only
#--------------------------------------------------
categorical_summary <- map_dfr(categorical_covars, function(var) {
    overall_tab <- dataframe %>%
        filter(!is.na(.data[[var]])) %>%
        count(level = .data[[var]], name = "overall_n")
    
    comp1_tab <- dataframe %>%
        filter(composite_2y == 1, !is.na(.data[[var]])) %>%
        count(level = .data[[var]], name = "comp1_n")
    
    full_join(overall_tab, comp1_tab, by = "level") %>%
        mutate(
            covariate = var,
            overall_n = ifelse(is.na(overall_n), 0, overall_n),
            comp1_n   = ifelse(is.na(comp1_n), 0, comp1_n)
        ) %>%
        select(covariate, level, overall_n, comp1_n)
})

#--------------------------------------------------
# 7) Univariate logistic regression for categorical covariates
#--------------------------------------------------
run_uni_logistic_categorical <- function(var, data, outcome = "composite_2y") {
    temp_data <- data %>%
        filter(!is.na(.data[[var]]), !is.na(.data[[outcome]])) %>%
        mutate(!!var := droplevels(.data[[var]]))
    
    formula <- as.formula(paste(outcome, "~", var))
    fit <- glm(formula, data = temp_data, family = binomial)
    co <- summary(fit)$coefficients
    
    ref_level <- levels(temp_data[[var]])[1]
    
    est <- co[grepl(paste0("^", var), rownames(co)), , drop = FALSE]
    
    nonref_df <- data.frame(
        covariate = var,
        level     = sub(paste0("^", var), "", rownames(est)),
        OR        = exp(est[, 1]),
        LCL       = exp(est[, 1] - 1.96 * est[, 2]),
        UCL       = exp(est[, 1] + 1.96 * est[, 2]),
        p         = est[, 4],
        row.names = NULL
    )
    
    ref_df <- data.frame(
        covariate = var,
        level     = ref_level,
        OR        = 1,
        LCL       = NA_real_,
        UCL       = NA_real_,
        p         = NA_real_
    )
    
    bind_rows(ref_df, nonref_df)
}

categorical_uni_results <- map_dfr(categorical_covars, ~ run_uni_logistic_categorical(.x, dataframe))

categorical_final <- categorical_summary %>%
    left_join(categorical_uni_results, by = c("covariate", "level"))

#--------------------------------------------------
# 8) Combine binary + categorical results
#--------------------------------------------------
final_uni_table <- bind_rows(binary_final, categorical_final) %>%
    mutate(
        OR  = round(OR, 7),
        LCL = round(LCL, 7),
        UCL = round(UCL, 7),
        p   = signif(p, 7)
    ) %>%
    select(covariate, level, overall_n, comp1_n, OR, LCL, UCL, p)

#--------------------------------------------------
# 9) Optional separate tables
#--------------------------------------------------
final_binary_table <- final_uni_table %>%
    filter(covariate %in% binary_covars)

final_categorical_table <- final_uni_table %>%
    filter(covariate %in% categorical_covars)

#--------------------------------------------------
# 10) View outputs
#--------------------------------------------------
final_uni_table
final_binary_table
final_categorical_table












#_________________________Multivariable analysis_______________________#
# ---- Defining all covariates vector (all binary variables already 0/1 from above) ----
all_vars <- c(
    "brain_tumor_concept_id","gad_concept_id","lob_concept_id","ts_concept_id",
    "depression_concept_id","migraine_concept_id","dementia_concept_id","tbi_concept_id", "ct_concept_id",
    "age_grp4","gender","race","ethnicity", "epilepsy_type"
)

# ---- Extracting OR, 95% CI, p from a glm() ----
tidy_or <- function(fit) {
    co <- coef(summary(fit))
    co <- co[rownames(co) != "(Intercept)", , drop = FALSE]
    data.frame(
        predictor = rownames(co),
        OR  = exp(co[, "Estimate"]),
        LCL = exp(co[, "Estimate"] - 1.96 * co[, "Std. Error"]),
        UCL = exp(co[, "Estimate"] + 1.96 * co[, "Std. Error"]),
        p   = co[, "Pr(>|z|)"],
        row.names = NULL
    )
}

# ---- Multivariable logistic models (all covariates at once) ----
fit_composite  <- glm(as.formula(paste("composite_2y ~",      paste(all_vars, collapse = " + "))), data = dataframe, family = binomial)


res_composite <- tidy_or(fit_composite)


# See results
res_composite