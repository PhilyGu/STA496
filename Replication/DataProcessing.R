library(fingertipsR)
library(tidyverse)
library(ggplot2)
library(ggridges)
library(ggjoy)
library(WVPlots)
library(stringr)
library(lattice)
library(kernlab)
library(caret)
library(caretEnsemble)
library(govstyle)
library(viridisLite)
library(viridis)
library(dplyr)
library(psych)
library(GPArotation)
library(data.table)
library(QuantPsyc)


## Identify suicide profiles
profiles <- profiles()
sui_profiles <- profiles %>%
  filter(str_detect(ProfileName, "[Ss]uicide"))


## Download profile data
dataset <- fingertips_data(ProfileID = 91,AreaTypeID = 102)



## Latest data
dataset_latest <- dataset %>%
  group_by(Age, Sex, IndicatorID, Category) %>%
  filter(TimeperiodSortable == max(TimeperiodSortable))


ds1 <- dataset_latest %>%
  ungroup() %>%
  filter(AreaType == "Counties & UAs (pre Apr 2019)") %>%
  mutate(index = paste(IndicatorName, Age, Sex, sep = "_")) %>%
  dplyr::select(c("AreaName", "index", "Value"))


## create wide table
analysis <- ds1 %>%
  tidyr::spread(key = index, value = Value)


## Check NAs
isna <- analysis %>%
  keep(is.numeric) %>%
  map_df(~sum(is.na(.))) %>%
  t() %>%
  as.data.frame() %>%
  rownames_to_column() %>%
  arrange(-V1)


isna %>%
  filter(V1 > 5) %>%
  arrange(-V1)


## Exclude variables
isna_filter <- isna %>%
  filter(V1 > 7) %>%
  pull(rowname)


## remove variables with a lot of missing data
analysis1 <- select_if(analysis, !names(analysis) %in% isna_filter)  


## exclude areas with no suicide rate in latest data
analysis1 <- analysis1 %>% 
  filter(!is.na(`Years of life lost due to suicide, age-standardised rate 15-74 years: per 10,000 population (3 year average)_15-74 yrs_Persons`
  ))


## Impute missing data to mean value
analysis1 <- analysis1 %>%
  map_df(function(x) ifelse(is.na(x),  mean(x, na.rm = TRUE), x))


## rename outcome variable and exclude other suicide variables
analysis1new <- analysis1 %>%
  rename(outcome = `Years of life lost due to suicide, age-standardised rate 15-74 years: per 10,000 population (3 year average)_15-74 yrs_Persons`) %>% 
  dplyr::select( -contains("suicide")) %>%
  rename(Suicide_Rate = 'outcome')


mean(is.na(analysis1new))

analysis_final_new <- analysis1new %>%
  dplyr::select(-AreaName)

#Move Suicide_Rate column to the first column
analysis_final_new <- analysis_final_new %>% dplyr::select(Suicide_Rate, everything())


#write.csv(analysis1new,file ="F:/Study/PHE/analysis1new.csv")
#write.csv(analysis_final_new,file ="F:/Study/PHE/analysis_final_new.csv")

# rename each variable with neat purpose 
name <- analysis_final_new %>%
  rename(variable1 = `Admission episodes for alcohol-related conditions (Broad): Old Method_All ages_Female`) %>%
  rename(variable2 = `Admission episodes for alcohol-related conditions (Broad): Old Method_All ages_Male`) %>%
  rename(variable3 = `Admission episodes for alcohol-related conditions (Broad): Old Method_All ages_Persons`) %>%
  rename(variable4 = `Adults in treatment at specialist alcohol misuse services: rate per 1000 population_18+ yrs_Persons`) %>%
  rename(variable5 = `Adults in treatment at specialist drug misuse services: rate per 1000 population_18+ yrs_Persons` ) %>%
  rename(variable6 = `Children in care_<18 yrs_Persons`) %>%
  rename(variable7 = `Children in the youth justice system (10-17 yrs)_10-17 yrs_Persons`) %>%
  rename(variable8 = `Children leaving care: rate per 10,000 children aged under 18_<18 yrs_Persons`) %>%
  rename(variable9 = `Depression: Recorded prevalence (aged 18+)_18+ yrs_Persons`) %>%
  rename(variable10 = `Emergency Hospital Admissions for Intentional Self-Harm_All ages_Female`) %>%
  rename(variable11 = `Emergency Hospital Admissions for Intentional Self-Harm_All ages_Male`) %>%
  rename(variable12 = `Emergency Hospital Admissions for Intentional Self-Harm_All ages_Persons`) %>%
  rename(variable13 = `Estimated prevalence of common mental disorders: % of population aged 16 & over_16+ yrs_Persons`) %>%
  rename(variable14 = `Estimated prevalence of common mental disorders: % of population aged 65 & over_65+ yrs_Persons`) %>%
  rename(variable15 = `Estimated prevalence of opiate and/or crack cocaine use_15-64 yrs_Persons`) %>%
  rename(variable16 = `Long-term health problem or disability: % of population_All ages_Persons`) %>%
  rename(variable17 = `Long term claimants of Jobseeker's Allowance_16-64 yrs_Persons`) %>%
  rename(variable18 = `Marital breakup: % of adults_18+ yrs_Persons`) %>%
  rename(variable19 = `Mental Health: QOF prevalence (all ages)_All ages_Persons`) %>%
  rename(variable20 = `Older people living alone: % of households occupied by a single person aged 65 or over_65+ yrs_Persons`) %>%
  rename(variable21 = `People living alone: % of all usual residents in households occupied by a single person_All ages_Persons`) %>%
  rename(variable22 = `Self-reported wellbeing - people with a high anxiety score_16+ yrs_Persons`) %>%
  rename(variable23 = `Social Isolation: percentage of adult carers who have as much social contact as they would like_18-64 yrs_Persons`) %>%
  rename(variable24 = `Social Isolation: percentage of adult carers who have as much social contact as they would like_18+ yrs_Persons`) %>%
  rename(variable25 = `Social Isolation: percentage of adult carers who have as much social contact as they would like_65+ yrs_Persons`) %>%
  rename(variable26 = `Social Isolation: percentage of adult carers who have as much social contact as they would like_All ages_Persons`) %>%
  rename(variable27 = `Social Isolation: percentage of adult social care users who have as much social contact as they would like_18+ yrs_Persons`) %>%
  rename(variable28 = `Successful completion of alcohol treatment_18+ yrs_Persons`) %>%
  rename(variable29 = `Successful completion of drug treatment - non-opiate users_18+ yrs_Persons`) %>%
  rename(variable30 = `Successful completion of drug treatment - opiate users_18+ yrs_Persons`) %>%
  rename(variable31 = `Unemployment (model-based)_16+ yrs_Persons`) 


