clear
version 19
use "C:\Users\laxfr\Desktop\All-Comers\Onc-BMT\Stata\Data\All Admitted Onc-BMT Modified Table 1 Data (Updated).dta"

merge m:m DischargeID using "C:\Users\laxfr\Desktop\All-Comers\Trisomy\Stata\Data\All Trisomy Patients Modified Table 1 (Updated).dta"

rename _merge _merge_trisomy
tab high_risk_group_onc high_risk_group_T1318


merge m:m DischargeID using "C:\Users\laxfr\Desktop\All-Comers\Trauma\Stata\Data\All Trauma Patients Modified Table 1 (Updated).dta"

rename _merge _merge_trauma

tab high_risk_group_T1318 high_risk_group_trauma

merge m:m DischargeID using "C:\Users\laxfr\Desktop\All-Comers\All Patients\Stata\Data\All High Patients with ECMO Dx All Table 1 (Updated).dta"


rename _merge _merge_all

merge m:m DischargeID using "C:\Users\laxfr\Desktop\Fellowship Files\CHEAR Fellowship\Research\ECMO Practica 1\Data\All Hospital\Stata\Data\All ECMO Cases pulled by Px and Date.dta"

rename _merge _merge_ecmo 

merge m:m DischargeID using "C:\Users\laxfr\Desktop\All-Comers\All Patients\Stata\Data\ECMO Dx by Discharge ID.dta"

rename _merge _merge_ECMO_dx_ICD


set seed 12345

drop if HospitalNumber ==.
drop if DischargeID ==.

replace YearOfService = 1 if YearOfService == 2016
replace YearOfService = 2 if YearOfService == 2017
replace YearOfService = 3 if YearOfService == 2018
replace YearOfService = 4 if YearOfService == 2019
replace YearOfService = 5 if YearOfService == 2020
replace YearOfService = 6 if YearOfService == 2021
replace YearOfService = 7 if YearOfService == 2022
replace YearOfService = 8 if YearOfService == 2023
replace YearOfService = 9 if YearOfService == 2024


label define YearOfService 1 "2016" 2 "2017" 3 "2018" 4 "2019" 5 "2020" 6 "2021" 7 "2022" 8 "2023" 9 "2024"
label values YearOfService YearOfService

replace AdmitYear = 1 if AdmitYear == 2016
replace AdmitYear = 2 if AdmitYear == 2017
replace AdmitYear = 3 if AdmitYear == 2018
replace AdmitYear = 4 if AdmitYear == 2019
replace AdmitYear = 5 if AdmitYear == 2020
replace AdmitYear = 6 if AdmitYear == 2021
replace AdmitYear = 7 if AdmitYear == 2022
replace AdmitYear = 8 if AdmitYear == 2023
replace AdmitYear = 9 if AdmitYear == 2024

drop if AdmitYear ==.


label define AdmitYear 1 "2016" 2 "2017" 3 "2018" 4 "2019" 5 "2020" 6 "2021" 7 "2022" 8 "2023" 9 "2024"
label values AdmitYear AdmitYear

tab AdmitYear YearOfService

replace YearOfService = AdmitYear if YearOfService ==.

gen high_risk_group =.
replace high_risk_group = 0 if high_risk_group_T1318 ==0 & high_risk_group_onc ==. & high_risk_group_trauma ==.
replace high_risk_group = 1 if high_risk_group_trauma ==1 & high_risk_group_T1318 ==. & high_risk_group_onc ==.
replace high_risk_group = 2 if high_risk_group_onc ==2 & high_risk_group_T1318 ==. & high_risk_group_trauma ==.
replace high_risk_group = 4 if high_risk_group_T1318 ==0 & high_risk_group_trauma ==1 & high_risk_group_onc ==.
replace high_risk_group = 0 if (high_risk_group ==4 | high_risk_group ==5)
replace high_risk_group = 5 if high_risk_group_T1318 ==0 & high_risk_group_onc ==2 & high_risk_group_trauma ==.
replace high_risk_group = 6 if high_risk_group_trauma ==1 & high_risk_group_onc ==2 & high_risk_group_T1318 ==.
replace high_risk_group = 2 if high_risk_group ==6

tab high_risk_group high_risk_group

replace high_risk_group =3 if high_risk_group ==.

tab high_risk_group high_risk_group


label define high_risk_group 0 "T13/18" 1 "Trauma" 2 "Onc/HSCT" 3 "Not High Risk" 4 "T13/18 & Trauma" 5 "T13/18 & Onc/HSCT" 6 "Trauma & Onc/HSCT"
label values high_risk_group high_risk_group

replace ECMO_dx_y_n =0 if ECMO_dx_y_n ==.

tab high_risk_group ECMO_dx_y_n

replace ecmo_type1=7 if ecmo_type1==.

**relabeling ecmo_type1**
label define ecmo_type1 0 "Unspeficied ECMO" 1 "Central VA ECMO" 2 "Peripheral VA ECMO" 3 "Peripheral VV ECMO" 4 "Central VA Intraoperative" 5 "Peripheral VA Intraoperative" 6 "Peripheral VV Intraoperative" 7 "no ECMO"
label values ecmo_type1 ecmo_type1

**gen ECMO_y_n**
gen ECMO_y_n =.
replace ECMO_y_n =1 if ecmo_type1 < 7
replace ECMO_y_n =0 if ecmo_type1 ==7

**relabeling ECMO_y_n**
label define ECMO_y_n 0 "No ECMO" 1 "ECMO"
label values ECMO_y_n ECMO_y_n

*merging New York*

replace HospitalNumber = 2026 if HospitalNumber == 9026


**GENERATING FREQUENCY TABLES ECMO ICD Dx**mak
tab ECMO_dx_ICD if ECMO_y_n ==1, sort
tab ECMO_dx_ICD if high_risk_group == 0 & ECMO_y_n ==1, sort
tab ECMO_dx_ICD if high_risk_group == 1 & ECMO_y_n ==1, sort
tab ECMO_dx_ICD if high_risk_group == 2 & ECMO_y_n ==1, sort
tab ECMO_dx_ICD if high_risk_group == 3 & ECMO_y_n ==1, sort


**GENDER REPLACEMENT**

replace Gender = . if Gender ==0

**Ethnicity Replacement**
replace Ethnicity = . if  Ethnicity ==3


*rename ecmo_type1**
rename ecmo_type1 ecmo_type_all

**TOTAL ECMO**
*generate first encounter*
preserve
bysort DischargeID: keep if _N==1

*generating total number of ecmo cases by center*
bysort HospitalNumber (DischargeID): egen center_totalecmo = sum(ECMO_y_n) 
bysort HospitalNumber (DischargeID): replace center_totalecmo = center_totalecmo[1]

**ADMITS BY HIGH RISK GROUP**
*generating number of onc/bmt cases by center*
bysort HospitalNumber (DischargeID): egen number_of_casesonc = count(DischargeID) if (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6) | high_risk_group == 5| high_risk_group ==6 
bysort HospitalNumber (number_of_casesonc): replace number_of_casesonc = number_of_casesonc[1]

*generating number of t13/18 cases by center*
bysort HospitalNumber (DischargeID): egen number_of_casest1318 = count(DischargeID) if (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5)
bysort HospitalNumber (number_of_casest1318): replace number_of_casest1318 = number_of_casest1318[1]

*generating number of trauma cases by center*
bysort HospitalNumber: egen number_of_casestrauma = count(DischargeID) if (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6)
bysort HospitalNumber (number_of_casestrauma): replace number_of_casestrauma = number_of_casestrauma[1]

**TRAUMA ECMO**

*generating number of ECMO by trauma 2016*
bysort HospitalNumber (DischargeID): egen ecmo_cases_trauma_2016 = count(DischargeID) if (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6) & ECMO_y_n == 1 & YearOfService ==1
bysort HospitalNumber (ecmo_cases_trauma_2016): replace ecmo_cases_trauma_2016 = ecmo_cases_trauma_2016[1]

*generating number of ECMO by trauma 2017*
bysort HospitalNumber: egen ecmo_cases_trauma_2017 = count(DischargeID) if (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6) & ECMO_y_n == 1 & YearOfService ==2
bysort HospitalNumber (ecmo_cases_trauma_2017): replace ecmo_cases_trauma_2017 = ecmo_cases_trauma_2017[1]

*generating number of ECMO by trauma 2018*
bysort HospitalNumber: egen ecmo_cases_trauma_2018 = count(DischargeID) if (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6) & ECMO_y_n == 1 & YearOfService ==3
bysort HospitalNumber (ecmo_cases_trauma_2018): replace ecmo_cases_trauma_2018 = ecmo_cases_trauma_2018[1]

*generating number of ECMO by trauma 2019*
bysort HospitalNumber: egen ecmo_cases_trauma_2019 = count(DischargeID) if (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6) & ECMO_y_n == 1 & YearOfService ==4
bysort HospitalNumber (ecmo_cases_trauma_2019): replace ecmo_cases_trauma_2019 = ecmo_cases_trauma_2019[1]

*generating number of ECMO by trauma 2020*
bysort HospitalNumber: egen ecmo_cases_trauma_2020 = count(DischargeID) if (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6) & ECMO_y_n == 1 & YearOfService ==5
bysort HospitalNumber (ecmo_cases_trauma_2020): replace ecmo_cases_trauma_2020 = ecmo_cases_trauma_2020[1]

*generating number of ECMO by trauma 2021*
bysort HospitalNumber: egen ecmo_cases_trauma_2021 = count(DischargeID) if (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6) & ECMO_y_n == 1 & YearOfService ==6
bysort HospitalNumber (ecmo_cases_trauma_2021): replace ecmo_cases_trauma_2021 = ecmo_cases_trauma_2021[1]

*generating number of ECMO by trauma 2022*
bysort HospitalNumber: egen ecmo_cases_trauma_2022 = count(DischargeID) if (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6) & ECMO_y_n == 1 & YearOfService ==7
bysort HospitalNumber (ecmo_cases_trauma_2022): replace ecmo_cases_trauma_2022 = ecmo_cases_trauma_2022[1]

*generating number of ECMO by trauma 2023*
bysort HospitalNumber: egen ecmo_cases_trauma_2023 = count(DischargeID) if (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6) & ECMO_y_n == 1 & YearOfService ==8
bysort HospitalNumber (ecmo_cases_trauma_2016): replace ecmo_cases_trauma_2023 = ecmo_cases_trauma_2023[1]

*generating number of ECMO by trauma 2024*
bysort HospitalNumber: egen ecmo_cases_trauma_2024 = count(DischargeID) if (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6) & ECMO_y_n == 1 & YearOfService ==9
bysort HospitalNumber (ecmo_cases_trauma_2024): replace ecmo_cases_trauma_2024 = ecmo_cases_trauma_2024[1]

**TRISOMY ECMO**
*generating number of ECMO by trisomy 2016*
bysort HospitalNumber: egen ecmo_cases_trisomy_2016 = count(DischargeID) if (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5) & ECMO_y_n == 1 & YearOfService ==1
bysort HospitalNumber (ecmo_cases_trisomy_2016): replace ecmo_cases_trisomy_2016 = ecmo_cases_trisomy_2016[1]

*generating number of ECMO by trisomy 2017*
bysort HospitalNumber: egen ecmo_cases_trisomy_2017 = count(DischargeID) if (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5) & ECMO_y_n == 1 & YearOfService ==2
bysort HospitalNumber (ecmo_cases_trisomy_2017): replace ecmo_cases_trisomy_2017 = ecmo_cases_trisomy_2017[1]

*generating number of ECMO by trisomy 2018*
bysort HospitalNumber: egen ecmo_cases_trisomy_2018 = count(DischargeID) if (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5) & ECMO_y_n == 1 & YearOfService ==3
bysort HospitalNumber (ecmo_cases_trisomy_2018): replace ecmo_cases_trisomy_2018 = ecmo_cases_trisomy_2018[1]

*generating number of ECMO by trisomy 2019*
bysort HospitalNumber: egen ecmo_cases_trisomy_2019 = count(DischargeID) if (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5) & ECMO_y_n == 1 & YearOfService ==4
bysort HospitalNumber (ecmo_cases_trisomy_2019): replace ecmo_cases_trisomy_2019 = ecmo_cases_trisomy_2019[1]

*generating number of ECMO by trisomy 2020*
bysort HospitalNumber: egen ecmo_cases_trisomy_2020 = count(DischargeID) if (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5) & ECMO_y_n == 1 & YearOfService ==5
bysort HospitalNumber (ecmo_cases_trisomy_2020): replace ecmo_cases_trisomy_2020 = ecmo_cases_trisomy_2020[1]

*generating number of ECMO by trisomy 2021*
bysort HospitalNumber: egen ecmo_cases_trisomy_2021 = count(DischargeID) if (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5) & ECMO_y_n == 1 & YearOfService ==6
bysort HospitalNumber (ecmo_cases_trisomy_2021): replace ecmo_cases_trisomy_2021 = ecmo_cases_trisomy_2021[1]

*generating number of ECMO by trisomy 2022*
bysort HospitalNumber: egen ecmo_cases_trisomy_2022 = count(DischargeID) if (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5) & ECMO_y_n == 1 & YearOfService ==7
bysort HospitalNumber (ecmo_cases_trisomy_2022): replace ecmo_cases_trisomy_2022 = ecmo_cases_trisomy_2022[1]

*generating number of ECMO by trisomy 2023*
bysort HospitalNumber: egen ecmo_cases_trisomy_2023 = count(DischargeID) if (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5) & ECMO_y_n == 1 & YearOfService ==8
bysort HospitalNumber (ecmo_cases_trisomy_2016): replace ecmo_cases_trisomy_2023 = ecmo_cases_trisomy_2023[1]

*generating number of ECMO by trisomy 2024*
bysort HospitalNumber: egen ecmo_cases_trisomy_2024 = count(DischargeID) if (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5) & ECMO_y_n == 1 & YearOfService ==9
bysort HospitalNumber (ecmo_cases_trisomy_2024): replace ecmo_cases_trisomy_2024 = ecmo_cases_trisomy_2024[1]

**ONC ECMO**
*generating number of ECMO by onc 2016*
bysort HospitalNumber: egen ecmo_cases_onc_2016 = count(DischargeID) if (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6) & ECMO_y_n == 1 & YearOfService ==1
bysort HospitalNumber (ecmo_cases_onc_2016): replace ecmo_cases_onc_2016 = ecmo_cases_onc_2016[1]

*generating number of ECMO by onc 2017*
bysort HospitalNumber: egen ecmo_cases_onc_2017 = count(DischargeID) if (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6) & ECMO_y_n == 1 & YearOfService ==2
bysort HospitalNumber (ecmo_cases_onc_2017): replace ecmo_cases_onc_2017 = ecmo_cases_onc_2017[1]

*generating number of ECMO by onc 2018*
bysort HospitalNumber: egen ecmo_cases_onc_2018 = count(DischargeID) if (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6) & ECMO_y_n == 1 & YearOfService ==3
bysort HospitalNumber (ecmo_cases_onc_2018): replace ecmo_cases_onc_2018 = ecmo_cases_onc_2018[1]

*generating number of ECMO by onc 2019*
bysort HospitalNumber: egen ecmo_cases_onc_2019 = count(DischargeID) if (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6) & ECMO_y_n == 1 & YearOfService ==4
bysort HospitalNumber (ecmo_cases_onc_2019): replace ecmo_cases_onc_2019 = ecmo_cases_onc_2019[1]

*generating number of ECMO by onc 2020*
bysort HospitalNumber: egen ecmo_cases_onc_2020 = count(DischargeID) if (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6) & ECMO_y_n == 1 & YearOfService ==5
bysort HospitalNumber (ecmo_cases_onc_2020): replace ecmo_cases_onc_2020 = ecmo_cases_onc_2020[1]

*generating number of ECMO by onc 2021*
bysort HospitalNumber: egen ecmo_cases_onc_2021 = count(DischargeID) if (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6) & ECMO_y_n == 1 & YearOfService ==6
bysort HospitalNumber (ecmo_cases_onc_2021): replace ecmo_cases_onc_2021 = ecmo_cases_onc_2021[1]

*generating number of ECMO by onc 2022*
bysort HospitalNumber: egen ecmo_cases_onc_2022 = count(DischargeID) if (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6) & ECMO_y_n == 1 & YearOfService ==7
bysort HospitalNumber (ecmo_cases_onc_2022): replace ecmo_cases_onc_2022 = ecmo_cases_onc_2022[1]

*generating number of ECMO by onc 2023*
bysort HospitalNumber: egen ecmo_cases_onc_2023 = count(DischargeID) if (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6) & ECMO_y_n == 1 & YearOfService ==8
bysort HospitalNumber (ecmo_cases_onc_2016): replace ecmo_cases_onc_2023 = ecmo_cases_onc_2023[1]

*generating number of ECMO by onc 2024*
bysort HospitalNumber: egen ecmo_cases_onc_2024 = count(DischargeID) if (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6) & ECMO_y_n == 1 & YearOfService ==9
bysort HospitalNumber (ecmo_cases_onc_2024): replace ecmo_cases_onc_2024 = ecmo_cases_onc_2024[1]

**NOT HIGH RISK ECMO**
*generating number of ECMO by nhr 2016*
bysort HospitalNumber: egen ecmo_cases_nhr_2016 = count(DischargeID) if high_risk_group ==3 & ECMO_y_n == 1 & YearOfService ==1
bysort HospitalNumber (ecmo_cases_nhr_2016): replace ecmo_cases_nhr_2016 = ecmo_cases_nhr_2016[1]

*generating number of ECMO by nhr 2017*
bysort HospitalNumber: egen ecmo_cases_nhr_2017 = count(DischargeID) if high_risk_group ==3 & ECMO_y_n == 1 & YearOfService ==2
bysort HospitalNumber (ecmo_cases_nhr_2017): replace ecmo_cases_nhr_2017 = ecmo_cases_nhr_2017[1]

*generating number of ECMO by nhr 2018*
bysort HospitalNumber: egen ecmo_cases_nhr_2018 = count(DischargeID) if high_risk_group ==3 & ECMO_y_n == 1 & YearOfService ==3
bysort HospitalNumber (ecmo_cases_nhr_2018): replace ecmo_cases_nhr_2018 = ecmo_cases_nhr_2018[1]

*generating number of ECMO by nhr 2019*
bysort HospitalNumber: egen ecmo_cases_nhr_2019 = count(DischargeID) if high_risk_group ==3 & ECMO_y_n == 1 & YearOfService ==4
bysort HospitalNumber (ecmo_cases_nhr_2019): replace ecmo_cases_nhr_2019 = ecmo_cases_nhr_2019[1]

*generating number of ECMO by nhr 2020*
bysort HospitalNumber: egen ecmo_cases_nhr_2020 = count(DischargeID) if high_risk_group ==3 & ECMO_y_n == 1 & YearOfService ==5
bysort HospitalNumber (ecmo_cases_nhr_2020): replace ecmo_cases_nhr_2020 = ecmo_cases_nhr_2020[1]

*generating number of ECMO by nhr 2021*
bysort HospitalNumber: egen ecmo_cases_nhr_2021 = count(DischargeID) if high_risk_group ==3 & ECMO_y_n == 1 & YearOfService ==6
bysort HospitalNumber (ecmo_cases_nhr_2021): replace ecmo_cases_nhr_2021 = ecmo_cases_nhr_2021[1]

*generating number of ECMO by nhr 2022*
bysort HospitalNumber: egen ecmo_cases_nhr_2022 = count(DischargeID) if high_risk_group ==3 & ECMO_y_n == 1 & YearOfService ==7
bysort HospitalNumber (ecmo_cases_nhr_2022): replace ecmo_cases_nhr_2022 = ecmo_cases_nhr_2022[1]

*generating number of ECMO by nhr 2023*
bysort HospitalNumber: egen ecmo_cases_nhr_2023 = count(DischargeID) if high_risk_group ==3 & ECMO_y_n == 1 & YearOfService ==8
bysort HospitalNumber (ecmo_cases_nhr_2016): replace ecmo_cases_nhr_2023 = ecmo_cases_nhr_2023[1]

*generating number of ECMO by nhr 2024*
bysort HospitalNumber: egen ecmo_cases_nhr_2024 = count(DischargeID) if high_risk_group ==3 & ECMO_y_n == 1 & YearOfService ==9
bysort HospitalNumber (ecmo_cases_nhr_2024): replace ecmo_cases_nhr_2024 = ecmo_cases_nhr_2024[1]

**GENERATING CENTER TOTAL ADMISSIONS**
bysort HospitalNumber: egen center_admissions = count(DischargeID) if AdmitYear == 1 | AdmitYear == 2 | AdmitYear == 3 | AdmitYear == 4 | AdmitYear == 5 | AdmitYear == 6 | AdmitYear == 7 | AdmitYear == 8 | AdmitYear == 9

**CENTER ADMISSIONS BY YEAR**

*generating center number of admissions by year (2016)*
bysort HospitalNumber: egen center_admissions_2016= count(DischargeID) if AdmitYear ==1
bysort HospitalNumber (center_admissions_2016): replace center_admissions_2016= center_admissions_2016[1]

*generating center number of admissions by year (2017)*
bysort HospitalNumber: egen center_admissions_2017= count(DischargeID) if AdmitYear ==2
bysort HospitalNumber (center_admissions_2017): replace center_admissions_2017 = center_admissions_2017[1]

*generating center number of admissions by year (2018)*
bysort HospitalNumber: egen center_admissions_2018= count(DischargeID) if AdmitYear ==3
bysort HospitalNumber (center_admissions_2018): replace center_admissions_2018 = center_admissions_2018[1]

*generating center number of admissions by year (2019)*
bysort HospitalNumber: egen center_admissions_2019= count(DischargeID) if AdmitYear ==4
bysort HospitalNumber (center_admissions_2019): replace center_admissions_2019 = center_admissions_2019[1]

*generating center number of admissions by year (2020)*
bysort HospitalNumber: egen center_admissions_2020= count(DischargeID) if AdmitYear ==5
bysort HospitalNumber (center_admissions_2020): replace center_admissions_2020 = center_admissions_2020[1]

*generating center number of admissions by year (2021)*
bysort HospitalNumber: egen center_admissions_2021= count(DischargeID) if AdmitYear ==6
bysort HospitalNumber (center_admissions_2021): replace center_admissions_2021 = center_admissions_2021[1]

*generating center number of admissions by year (2022)*
bysort HospitalNumber: egen center_admissions_2022= count(DischargeID) if AdmitYear ==7
bysort HospitalNumber (center_admissions_2022): replace center_admissions_2022 = center_admissions_2022[1]

*generating center number of admissions by year (2023)*
bysort HospitalNumber: egen center_admissions_2023= count(DischargeID) if AdmitYear ==8
bysort HospitalNumber (center_admissions_2023): replace center_admissions_2023= center_admissions_2023[1]

*generating center number of admissions by year (2024)*
bysort HospitalNumber: egen center_admissions_2024= count(DischargeID) if AdmitYear ==9
bysort HospitalNumber (center_admissions_2024): replace center_admissions_2024 = center_admissions_2024[1]

egen total_admissions= count(DischargeID)

**CENTER ECMO CASES BY YEAR**

*generating center number of ecmo cases by year (2016)*
bysort HospitalNumber: egen center_total_ecmo_2016= count(DischargeID) if YearOfService ==1 & ECMO_y_n ==1
bysort HospitalNumber (center_total_ecmo_2016): replace center_total_ecmo_2016= center_total_ecmo_2016[1]

*generating center number of ecmo cases by year (2017)*
bysort HospitalNumber: egen center_total_ecmo_2017= count(DischargeID) if YearOfService ==2 & ECMO_y_n ==1
bysort HospitalNumber (center_total_ecmo_2017): replace center_total_ecmo_2017= center_total_ecmo_2017[1]

*generating center number of ecmo cases by year (2018)*
bysort HospitalNumber: egen center_total_ecmo_2018= count(DischargeID) if YearOfService ==3 & ECMO_y_n ==1
bysort HospitalNumber (center_total_ecmo_2018): replace center_total_ecmo_2018= center_total_ecmo_2018[1]

*generating center number of ecmo cases by year (2019)*
bysort HospitalNumber: egen center_total_ecmo_2019= count(DischargeID) if YearOfService ==4 & ECMO_y_n ==1
bysort HospitalNumber (center_total_ecmo_2019): replace center_total_ecmo_2019= center_total_ecmo_2019[1]

*generating center number of ecmo cases by year (2020)*
bysort HospitalNumber: egen center_total_ecmo_2020= count(DischargeID) if YearOfService ==5 & ECMO_y_n ==1
bysort HospitalNumber (center_total_ecmo_2020): replace center_total_ecmo_2020 = center_total_ecmo_2020[1]

*generating center number of ecmo cases by year (2021)*
bysort HospitalNumber: egen center_total_ecmo_2021= count(DischargeID) if YearOfService ==6 & ECMO_y_n ==1
bysort HospitalNumber (center_total_ecmo_2021): replace center_total_ecmo_2021 = center_total_ecmo_2021[1]

*generating center number of ecmo cases by year (2022)*
bysort HospitalNumber: egen center_total_ecmo_2022= count(DischargeID) if YearOfService ==7 & ECMO_y_n ==1
bysort HospitalNumber (center_total_ecmo_2022): replace center_total_ecmo_2022 = center_total_ecmo_2022[1]

*generating center number of ecmo cases by year (2023)*
bysort HospitalNumber: egen center_total_ecmo_2023= count(DischargeID) if YearOfService ==8 & ECMO_y_n ==1
bysort HospitalNumber (center_total_ecmo_2023): replace center_total_ecmo_2023 = center_total_ecmo_2023[1]

*generating center number of ecmo cases by year (2024)*
bysort HospitalNumber: egen center_total_ecmo_2024= count(DischargeID) if YearOfService ==9 & ECMO_y_n ==1
bysort HospitalNumber (center_total_ecmo_2024): replace center_total_ecmo_2024 = center_total_ecmo_2024[1]

**GENERATING MEAN CENTER ADMISSIONS**

*generating mean number of admissions*
egen mean_center_admissions = mean(center_admissions)

**GENERATING MEAN CENTER ECMO**
*generating  mean number of ecmo cases*
egen mean_center_totalecmo = mean(center_totalecmo)

*generating mean number of t13/t18 admissions*
egen mean_number_of_casest1318 = mean(number_of_casest1318)

*generating mean number of trauma admissions*
egen mean_number_of_casestrauma = mean(number_of_casestrauma)

*generating mean number of onc admissions*
egen mean_number_of_casesonc = mean(number_of_casesonc)

**--**

*Generating Total Number of ECMO Cases - ALL CENTERS*
egen total_ECMO = sum(ECMO_y_n)

*Generating Total Number of ECMO Cases T1318 - ALL CENTERS*
egen total_ECMO_T1318 = sum(ECMO_y_n) if (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5)
bysort total_ECMO_T1318: replace total_ECMO_T1318 = total_ECMO_T1318[1]

*Generating Total Number of ECMO Cases trauma - ALL CENTERS*
egen total_ECMO_trauma = sum(ECMO_y_n) if (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6)
bysort total_ECMO_trauma: replace total_ECMO_trauma = total_ECMO_trauma[1]

*Generating Total Number of ECMO Cases Onc - ALL CENTERS*
egen total_ECMO_onc = sum(ECMO_y_n) if (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6)
bysort total_ECMO_onc: replace total_ECMO_onc = total_ECMO_onc[1]

*Generating Total Number of ECMO Cases Not High Risk- ALL CENTERS*
egen total_ECMO_nhr = sum(ECMO_y_n) if high_risk_group ==3
bysort total_ECMO_nhr: replace total_ECMO_nhr = total_ECMO_nhr[1]

bysort DischargeID: gen obsnum = _n

**GENERATING TOTAL ADMISSIONS BY YEAR **
*2016*
bysort obsnum: egen total_admissions_2016 = count(DischargeID) if YearOfService ==1 
sort total_admissions_2016 
replace total_admissions_2016 = total_admissions_2016[1]

*2017*
bysort obsnum: egen total_admissions_2017 = count(DischargeID) if YearOfService ==2 
sort total_admissions_2017 
replace total_admissions_2017 = total_admissions_2017[1]

*2018*
bysort obsnum: egen total_admissions_2018 = count(DischargeID) if YearOfService ==3 
sort total_admissions_2018 
replace total_admissions_2018 = total_admissions_2018[1]

*2019*
bysort obsnum: egen total_admissions_2019 = count(DischargeID) if YearOfService ==4 
sort total_admissions_2019 
replace total_admissions_2019 = total_admissions_2019[1]

*2020*
bysort obsnum: egen total_admissions_2020 = count(DischargeID) if YearOfService ==5 
sort total_admissions_2020 
replace total_admissions_2020 = total_admissions_2020[1]

*2021*
bysort obsnum: egen total_admissions_2021 = count(DischargeID) if YearOfService ==6 
sort total_admissions_2021 
replace total_admissions_2021 = total_admissions_2021[1]

*2022*
bysort obsnum: egen total_admissions_2022 = count(DischargeID) if YearOfService ==7 
sort total_admissions_2022 
replace total_admissions_2022 = total_admissions_2022[1]

*2023*
bysort obsnum: egen total_admissions_2023 = count(DischargeID) if YearOfService ==8 
sort total_admissions_2023 
replace total_admissions_2023 = total_admissions_2023[1]

*2024*
bysort obsnum: egen total_admissions_2024 = count(DischargeID) if YearOfService ==9 
sort total_admissions_2024 
replace total_admissions_2024 = total_admissions_2024[1]


*generating annual total admissions - All Patients*
gen annual_total_admissions = .

*2016
replace annual_total_admissions = total_admissions_2016 if YearOfService ==1 
bysort DischargeID: replace annual_total_admissions = annual_total_admissions[1]

*2017*
replace annual_total_admissions = total_admissions_2017 if YearOfService ==2 
bysort DischargeID: replace annual_total_admissions = annual_total_admissions[1]

*2018
replace annual_total_admissions = total_admissions_2018 if YearOfService ==3 
bysort DischargeID: replace annual_total_admissions = annual_total_admissions[1]

*2019*
replace annual_total_admissions = total_admissions_2019 if YearOfService ==4 
bysort DischargeID: replace annual_total_admissions = annual_total_admissions[1]

*2020*
replace annual_total_admissions = total_admissions_2020 if YearOfService ==5 
bysort DischargeID: replace annual_total_admissions = annual_total_admissions[1]

*2021*
replace annual_total_admissions = total_admissions_2021 if YearOfService ==6 
bysort DischargeID: replace annual_total_admissions = annual_total_admissions[1]

*2022*
replace annual_total_admissions = total_admissions_2022 if YearOfService ==7 
bysort DischargeID: replace annual_total_admissions = annual_total_admissions[1]

*2023*
replace annual_total_admissions = total_admissions_2023 if YearOfService ==8 
bysort DischargeID: replace annual_total_admissions = annual_total_admissions[1]

*2024*
replace annual_total_admissions = total_admissions_2024 if YearOfService ==9 
bysort DischargeID: replace annual_total_admissions = annual_total_admissions[1]


**GENERATING TOTAL ECMO CASES BY YEAR - ALL CENTERS**
*2016 ECMO Cases*
bysort obsnum: egen total_ECMO_2016 = count(DischargeID) if ECMO_y_n == 1 & YearOfService ==1  
sort total_ECMO_2016
replace total_ECMO_2016 = total_ECMO_2016[1]



*2017 ECMO Cases*
bysort obsnum: egen total_ECMO_2017 = count(DischargeID) if ECMO_y_n == 1 & YearOfService ==2 
sort total_ECMO_2017
replace total_ECMO_2017 = total_ECMO_2017[1]


*2018 ECMO Cases*
bysort obsnum: egen total_ECMO_2018 = count(DischargeID) if ECMO_y_n == 1 & YearOfService ==3 
sort total_ECMO_2018
replace total_ECMO_2018 = total_ECMO_2018[1]

*2019 ECMO Cases*
bysort obsnum: egen total_ECMO_2019 = count(DischargeID) if ECMO_y_n == 1 & YearOfService ==4 
sort total_ECMO_2019
replace total_ECMO_2019 = total_ECMO_2019[1]


*2020 ECMO Cases*
bysort obsnum: egen total_ECMO_2020 = count(DischargeID) if ECMO_y_n == 1 & YearOfService ==5 
sort total_ECMO_2020
replace total_ECMO_2020 = total_ECMO_2020[1]



*2021 ECMO Cases*
bysort obsnum: egen total_ECMO_2021 = count(DischargeID) if ECMO_y_n == 1 & YearOfService ==6 
sort total_ECMO_2021
replace total_ECMO_2021 = total_ECMO_2021[1]


*2022 ECMO Cases*
bysort obsnum: egen total_ECMO_2022 = count(DischargeID) if ECMO_y_n == 1 & YearOfService ==7 
sort total_ECMO_2022
replace total_ECMO_2022 = total_ECMO_2022[1]

*2023 ECMO Cases*
bysort obsnum: egen total_ECMO_2023 = count(DischargeID) if ECMO_y_n == 1 & YearOfService ==8 
sort total_ECMO_2023
replace total_ECMO_2023 = total_ECMO_2023[1]


*2024 ECMO Cases*
bysort obsnum: egen total_ECMO_2024 = count(DischargeID) if ECMO_y_n == 1 & YearOfService ==9 
sort total_ECMO_2024
replace total_ECMO_2024 = total_ECMO_2024[1]

**GENERATING ANNUAL TOTAL ECMO CASES BY YEAR**
gen annual_total_ECMO =.
replace annual_total_ECMO = total_ECMO_2016 if YearOfService ==1  
bysort HospitalNumber: replace annual_total_ECMO = annual_total_ECMO
replace annual_total_ECMO = total_ECMO_2017 if YearOfService ==2 
bysort HospitalNumber: replace annual_total_ECMO = annual_total_ECMO
replace annual_total_ECMO = total_ECMO_2018 if YearOfService ==3
bysort HospitalNumber: replace annual_total_ECMO = annual_total_ECMO
replace annual_total_ECMO = total_ECMO_2019 if YearOfService ==4 
bysort HospitalNumber: replace annual_total_ECMO = annual_total_ECMO
replace annual_total_ECMO = total_ECMO_2020 if YearOfService ==5 
bysort HospitalNumber: replace annual_total_ECMO = annual_total_ECMO
replace annual_total_ECMO = total_ECMO_2021 if YearOfService ==6 
bysort HospitalNumber: replace annual_total_ECMO = annual_total_ECMO
replace annual_total_ECMO = total_ECMO_2022 if YearOfService ==7 
bysort HospitalNumber: replace annual_total_ECMO = annual_total_ECMO
replace annual_total_ECMO = total_ECMO_2023 if YearOfService ==8 
bysort HospitalNumber: replace annual_total_ECMO = annual_total_ECMO
replace annual_total_ECMO = total_ECMO_2024 if YearOfService ==9 
bysort HospitalNumber: replace annual_total_ECMO = annual_total_ECMO

**NOT HR**
*Generating Not High Risk Admissions - ALL HOSPITALS*

**GENERATING TOTAL ADMISSIONS BY YEAR **
*2016*
**GENERATING TOTAL ADMISSIONS BY YEAR **
*2016*
bysort obsnum: egen total_admissions_2016_nhr = count(DischargeID) if high_risk_group ==3 & YearOfService ==1 
sort total_admissions_2016_nhr 
replace total_admissions_2016_nhr = total_admissions_2016_nhr[1]

*2017*
bysort obsnum: egen total_admissions_2017_nhr = count(DischargeID) if high_risk_group ==3 & YearOfService ==2 
sort total_admissions_2017_nhr 
replace total_admissions_2017_nhr = total_admissions_2017_nhr[1]

*2018*
bysort obsnum: egen total_admissions_2018_nhr = count(DischargeID) if high_risk_group ==3 & YearOfService ==3 
sort total_admissions_2018_nhr 
replace total_admissions_2018_nhr = total_admissions_2018_nhr[1]

*2019*
bysort obsnum: egen total_admissions_2019_nhr = count(DischargeID) if high_risk_group ==3 & YearOfService ==4 
sort total_admissions_2019_nhr 
replace total_admissions_2019_nhr = total_admissions_2019_nhr[1]

*2020*
bysort obsnum: egen total_admissions_2020_nhr = count(DischargeID) if high_risk_group ==3 & YearOfService ==5 
sort total_admissions_2020_nhr 
replace total_admissions_2020_nhr = total_admissions_2020_nhr[1]

*2021*
bysort obsnum: egen total_admissions_2021_nhr = count(DischargeID) if high_risk_group ==3 & YearOfService ==6 
sort total_admissions_2021_nhr 
replace total_admissions_2021_nhr = total_admissions_2021_nhr[1]

*2022*
bysort obsnum: egen total_admissions_2022_nhr = count(DischargeID) if high_risk_group ==3 & YearOfService ==7 
sort total_admissions_2022_nhr 
replace total_admissions_2022_nhr = total_admissions_2022_nhr[1]

*2023*
bysort obsnum: egen total_admissions_2023_nhr = count(DischargeID) if high_risk_group ==3 & YearOfService ==8 
sort total_admissions_2023_nhr 
replace total_admissions_2023_nhr = total_admissions_2023_nhr[1]

*2024*
bysort obsnum: egen total_admissions_2024_nhr = count(DischargeID) if high_risk_group ==3 & YearOfService ==8 
sort total_admissions_2024_nhr 
replace total_admissions_2024_nhr = total_admissions_2024_nhr[1]


*generating annual total admissions variable Not High Risk*
gen annual_total_admissions_nhr = .
*2016
bysort DischargeID: replace annual_total_admissions_nhr = total_admissions_2016_nhr if YearOfService ==1 
bysort DischargeID: replace annual_total_admissions_nhr = annual_total_admissions_nhr[1]

*2017*
bysort DischargeID: replace annual_total_admissions_nhr = total_admissions_2017_nhr if YearOfService ==2 
bysort DischargeID: replace annual_total_admissions_nhr = annual_total_admissions_nhr[1]

*2018
bysort DischargeID: replace annual_total_admissions_nhr = total_admissions_2018_nhr if YearOfService ==3 

bysort DischargeID: replace annual_total_admissions_nhr = annual_total_admissions_nhr[1]

*2019*
bysort DischargeID: replace annual_total_admissions_nhr = total_admissions_2019_nhr if YearOfService ==4 
bysort DischargeID: replace annual_total_admissions_nhr = annual_total_admissions_nhr[1]

*2020*
bysort DischargeID: replace annual_total_admissions_nhr = total_admissions_2020_nhr if YearOfService ==5 
bysort DischargeID: replace annual_total_admissions_nhr = annual_total_admissions_nhr[1]

*2021*
bysort DischargeID: replace annual_total_admissions_nhr = total_admissions_2021_nhr if YearOfService ==6 
bysort DischargeID: replace annual_total_admissions_nhr = annual_total_admissions_nhr[1]

*2022*
bysort DischargeID: replace annual_total_admissions_nhr = total_admissions_2022_nhr if YearOfService ==7 
bysort DischargeID: replace annual_total_admissions_nhr = annual_total_admissions_nhr[1]

*2023*
bysort DischargeID: replace annual_total_admissions_nhr = total_admissions_2023_nhr if YearOfService ==8 
bysort DischargeID: replace annual_total_admissions_nhr = annual_total_admissions_nhr[1]

*2024*
bysort DischargeID: replace annual_total_admissions_nhr = total_admissions_2024_nhr if YearOfService ==9 
bysort DischargeID: replace annual_total_admissions_nhr = annual_total_admissions_nhr[1]


**NOT HR ECMO**

**GENERATING TOTAL ECMO CASES NOT HIGH RISK BY YEAR - ALL CENTERS**
*2016 ECMO Cases*
*2016 ECMO Cases*
bysort obsnum: egen total_ECMO_2016_nhr_nhr = count(DischargeID) if ECMO_y_n == 1 & high_risk_group ==3 & YearOfService ==1 
sort total_ECMO_2016_nhr
replace total_ECMO_2016_nhr = total_ECMO_2016_nhr[1]

*2017 ECMO Cases*
bysort obsnum: egen total_ECMO_2017_nhr = count(DischargeID) if ECMO_y_n == 1 & high_risk_group ==3 & YearOfService ==2 
sort total_ECMO_2017_nhr
replace total_ECMO_2017_nhr = total_ECMO_2017_nhr[1]


*2018 ECMO Cases*
bysort obsnum: egen total_ECMO_2018_nhr = count(DischargeID) if ECMO_y_n == 1 & high_risk_group ==3 & YearOfService ==3 
sort total_ECMO_2018_nhr
replace total_ECMO_2018_nhr = total_ECMO_2018_nhr[1]

*2019 ECMO Cases*
bysort obsnum: egen total_ECMO_2019_nhr = count(DischargeID) if ECMO_y_n == 1 & high_risk_group ==3 & YearOfService ==4 
sort total_ECMO_2019_nhr
replace total_ECMO_2019_nhr = total_ECMO_2019_nhr[1]


*2020 ECMO Cases*
bysort obsnum: egen total_ECMO_2020_nhr = count(DischargeID) if ECMO_y_n == 1 & high_risk_group ==3 & YearOfService ==5 
sort total_ECMO_2020_nhr
replace total_ECMO_2020_nhr = total_ECMO_2020_nhr[1]


*2021 ECMO Cases*
bysort obsnum: egen total_ECMO_2021_nhr = count(DischargeID) if ECMO_y_n == 1 & high_risk_group ==3 & YearOfService ==6 
sort total_ECMO_2021_nhr
replace total_ECMO_2021_nhr = total_ECMO_2021_nhr[1]


*2022 ECMO Cases*
bysort obsnum: egen total_ECMO_2022_nhr = count(DischargeID) if ECMO_y_n == 1 & high_risk_group ==3 & YearOfService ==7 
sort total_ECMO_2022_nhr
replace total_ECMO_2022_nhr = total_ECMO_2022_nhr[1]

*2023 ECMO Cases*
bysort obsnum: egen total_ECMO_2023_nhr = count(DischargeID) if ECMO_y_n == 1 & high_risk_group ==3 & YearOfService ==8 
sort total_ECMO_2023_nhr
replace total_ECMO_2023_nhr = total_ECMO_2023_nhr[1]


*2024 ECMO Cases*
bysort obsnum: egen total_ECMO_2024_nhr = count(DischargeID) if ECMO_y_n == 1 & high_risk_group ==3 & YearOfService ==9 
sort total_ECMO_2024_nhr
replace total_ECMO_2024_nhr = total_ECMO_2024_nhr[1]


**GENERATING ANNUAL TOTAL NOT HIGH RISK ECMO CASES BY YEAR**

bysort DischargeID: gen annual_total_ECMO_nhr = total_ECMO_2016_nhr if YearOfService ==1  
bysort DischargeID: replace annual_total_ECMO_nhr = annual_total_ECMO_nhr[1]
replace annual_total_ECMO_nhr = total_ECMO_2017_nhr if YearOfService ==2 
bysort DischargeID: replace annual_total_ECMO_nhr = annual_total_ECMO_nhr[1]
replace annual_total_ECMO_nhr = total_ECMO_2018_nhr if YearOfService ==3
bysort DischargeID: replace annual_total_ECMO_nhr = annual_total_ECMO_nhr[1]
replace annual_total_ECMO_nhr = total_ECMO_2019_nhr if YearOfService ==4 
bysort DischargeID: replace annual_total_ECMO_nhr = annual_total_ECMO_nhr[1]
replace annual_total_ECMO_nhr = total_ECMO_2020_nhr if YearOfService ==5 
bysort DischargeID: replace annual_total_ECMO_nhr = annual_total_ECMO_nhr[1]
replace annual_total_ECMO_nhr = total_ECMO_2021_nhr if YearOfService ==6 
bysort DischargeID: replace annual_total_ECMO_nhr = annual_total_ECMO_nhr[1]
replace annual_total_ECMO_nhr = total_ECMO_2022_nhr if YearOfService ==7 
bysort DischargeID: replace annual_total_ECMO_nhr = annual_total_ECMO_nhr[1]
replace annual_total_ECMO_nhr = total_ECMO_2023_nhr if YearOfService ==8 
bysort DischargeID: replace annual_total_ECMO_nhr = annual_total_ECMO_nhr[1]
replace annual_total_ECMO_nhr = total_ECMO_2024_nhr if YearOfService ==9 
bysort DischargeID: replace annual_total_ECMO_nhr = annual_total_ECMO_nhr[1]
	
**NOT HR REGRESSION**

**GENERATING SINGLE VARIABLE REGRESSION FOR ANNUAL TOTAL ECMO NOT HIGH RISK - ALL PATIENTS**

bysort YearOfService: keep if _n==1
browse


drop if annual_total_ECMO_nhr ==.

tab annual_total_ECMO_nhr YearOfService
tab annual_total_admissions_nhr YearOfService
reg annual_total_ECMO_nhr
reg annual_total_admissions_nhr
reg annual_total_admissions_nhr YearOfService
reg annual_total_ECMO_nhr YearOfService annual_total_admissions_nhr



*Generating Trisomy 13/18 Admissions - ALL HOSPITALS*

**GENERATING TOTAL ADMISSIONS BY YEAR **
*2016*
bysort obsnum: egen total_admissions_2016_T1318 = count(DischargeID) if (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5) & YearOfService ==1 
sort total_admissions_2016_T1318 
replace total_admissions_2016_T1318 = total_admissions_2016_T1318[1]

*2017*
bysort obsnum: egen total_admissions_2017_T1318 = count(DischargeID) if (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5) & YearOfService ==2 
sort total_admissions_2017_T1318 
replace total_admissions_2017_T1318 = total_admissions_2017_T1318[1]

*2018*
bysort obsnum: egen total_admissions_2018_T1318 = count(DischargeID) if (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5) & YearOfService ==3 
sort total_admissions_2018_T1318 
replace total_admissions_2018_T1318 = total_admissions_2018_T1318[1]

*2019*
bysort obsnum: egen total_admissions_2019_T1318 = count(DischargeID) if (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5) & YearOfService ==4 
sort total_admissions_2019_T1318 
replace total_admissions_2019_T1318 = total_admissions_2019_T1318[1]

*2020*
bysort obsnum: egen total_admissions_2020_T1318 = count(DischargeID) if (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5) & YearOfService ==5 
sort total_admissions_2020_T1318 
replace total_admissions_2020_T1318 = total_admissions_2020_T1318[1]

*2021*
bysort obsnum: egen total_admissions_2021_T1318 = count(DischargeID) if (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5) & YearOfService ==6 
sort total_admissions_2021_T1318 
replace total_admissions_2021_T1318 = total_admissions_2021_T1318[1]

*2022*
bysort obsnum: egen total_admissions_2022_T1318 = count(DischargeID) if (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5) & YearOfService ==7 
sort total_admissions_2022_T1318 
replace total_admissions_2022_T1318 = total_admissions_2022_T1318[1]

*2023*
bysort obsnum: egen total_admissions_2023_T1318 = count(DischargeID) if (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5) & YearOfService ==8 
sort total_admissions_2023_T1318 
replace total_admissions_2023_T1318 = total_admissions_2023_T1318[1]

*2024*
bysort obsnum: egen total_admissions_2024_T1318 = count(DischargeID) if (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5) & YearOfService ==8 
sort total_admissions_2024_T1318 
replace total_admissions_2024_T1318 = total_admissions_2024_T1318[1]


*generating annual total admissions variable t13/18*
gen annual_total_admissions_T1318 = .
*2016
bysort DischargeID: replace annual_total_admissions_T1318 = total_admissions_2016_T1318 if YearOfService ==1 
bysort DischargeID: replace annual_total_admissions_T1318 = annual_total_admissions_T1318[1]

*2017*
bysort DischargeID: replace annual_total_admissions_T1318 = total_admissions_2017_T1318 if YearOfService ==2 
bysort DischargeID: replace annual_total_admissions_T1318 = annual_total_admissions_T1318[1]

*2018
bysort DischargeID: replace annual_total_admissions_T1318 = total_admissions_2018_T1318 if YearOfService ==3
bysort DischargeID: replace annual_total_admissions_T1318 = annual_total_admissions_T1318[1]

*2019*
bysort DischargeID: replace annual_total_admissions_T1318 = total_admissions_2019_T1318 if YearOfService ==4 
bysort DischargeID: replace annual_total_admissions_T1318 = annual_total_admissions_T1318[1]

*2020*
bysort DischargeID: replace annual_total_admissions_T1318 = total_admissions_2020_T1318 if YearOfService ==5 
bysort DischargeID: replace annual_total_admissions_T1318 = annual_total_admissions_T1318[1]

*2021*
bysort DischargeID: replace annual_total_admissions_T1318 = total_admissions_2021_T1318 if YearOfService ==6 
bysort DischargeID: replace annual_total_admissions_T1318 = annual_total_admissions_T1318[1]

*2022*
bysort DischargeID: replace annual_total_admissions_T1318 = total_admissions_2022_T1318 if YearOfService ==7 
bysort DischargeID: replace annual_total_admissions_T1318 = annual_total_admissions_T1318[1]

*2023*
bysort DischargeID: replace annual_total_admissions_T1318 = total_admissions_2023_T1318 if YearOfService ==8 
bysort DischargeID: replace annual_total_admissions_T1318 = annual_total_admissions_T1318[1]

*2024*
bysort DischargeID: replace annual_total_admissions_T1318 = total_admissions_2024_T1318 if YearOfService ==9 
bysort DischargeID: replace annual_total_admissions_T1318 = annual_total_admissions_T1318[1]
**ECMO**

**GENERATING TOTAL ECMO CASES TRISOMY 13/18 BY YEAR - ALL CENTERS**
*2016 ECMO Cases*
*2016 ECMO Cases*
bysort obsnum: egen total_ECMO_2016_T1318 = count(DischargeID) if ECMO_y_n == 1 & (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5) & YearOfService ==1 
sort total_ECMO_2016_T1318
replace total_ECMO_2016_T1318 = 0 if total_ECMO_2016_T1318 ==.
replace total_ECMO_2016_T1318 = total_ECMO_2016_T1318[1]


*2017 ECMO Cases*
bysort obsnum: egen total_ECMO_2017_T1318 = count(DischargeID) if ECMO_y_n == 1 & (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5) & YearOfService ==2 
sort total_ECMO_2017_T1318
replace total_ECMO_2017_T1318 = 0 if total_ECMO_2017_T1318 ==.
replace total_ECMO_2017_T1318 = total_ECMO_2017_T1318[1]

*2018 ECMO Cases*
bysort obsnum: egen total_ECMO_2018_T1318 = count(DischargeID) if ECMO_y_n == 1 & (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5) & YearOfService ==3 
sort total_ECMO_2018_T1318
replace total_ECMO_2018_T1318 = total_ECMO_2018_T1318[1]

*2019 ECMO Cases*
bysort obsnum: egen total_ECMO_2019_T1318 = count(DischargeID) if ECMO_y_n == 1 & (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5) & YearOfService ==4 
sort total_ECMO_2019_T1318
replace total_ECMO_2019_T1318 = total_ECMO_2019_T1318[1]


*2020 ECMO Cases*
bysort obsnum: egen total_ECMO_2020_T1318 = count(DischargeID) if ECMO_y_n == 1 & (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5) & YearOfService ==5 
sort total_ECMO_2020_T1318
replace total_ECMO_2020_T1318 = total_ECMO_2020_T1318[1]


*2021 ECMO Cases*
bysort obsnum: egen total_ECMO_2021_T1318 = count(DischargeID) if ECMO_y_n == 1 & (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5) & YearOfService ==6 
sort total_ECMO_2021_T1318
replace total_ECMO_2021_T1318 = total_ECMO_2021_T1318[1]


*2022 ECMO Cases*
bysort obsnum: egen total_ECMO_2022_T1318 = count(DischargeID) if ECMO_y_n == 1 & (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5) & YearOfService ==7 
sort total_ECMO_2022_T1318
replace total_ECMO_2022_T1318 = total_ECMO_2022_T1318[1]

*2023 ECMO Cases*
bysort obsnum: egen total_ECMO_2023_T1318 = count(DischargeID) if ECMO_y_n == 1 & (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5) & YearOfService ==8 
sort total_ECMO_2023_T1318
replace total_ECMO_2023_T1318 = total_ECMO_2023_T1318[1]


*2024 ECMO Cases*
bysort obsnum: egen total_ECMO_2024_T1318 = count(DischargeID) if ECMO_y_n == 1 & (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5) & YearOfService ==9 
sort total_ECMO_2024_T1318
replace total_ECMO_2024_T1318 = total_ECMO_2024_T1318[1]


**GENERATING ANNUAL TOTAL TRISOMY 1318 ECMO CASES **
gen annual_total_ECMO_T1318 =.

replace annual_total_ECMO_T1318 = total_ECMO_2016_T1318 if YearOfService ==1 
replace annual_total_ECMO_T1318 = total_ECMO_2017_T1318 if YearOfService ==2 
replace annual_total_ECMO_T1318 = total_ECMO_2018_T1318 if YearOfService ==3
replace annual_total_ECMO_T1318 = total_ECMO_2019_T1318 if YearOfService ==4 
replace annual_total_ECMO_T1318 = total_ECMO_2020_T1318 if YearOfService ==5 
replace annual_total_ECMO_T1318 = total_ECMO_2021_T1318 if YearOfService ==6 
replace annual_total_ECMO_T1318 = total_ECMO_2022_T1318 if YearOfService ==7 
replace annual_total_ECMO_T1318 = total_ECMO_2023_T1318 if YearOfService ==8 
replace annual_total_ECMO_T1318 = total_ECMO_2024_T1318 if YearOfService ==9 

**GENERATING SINGLE VARIABLE REGRESSION FOR ANNUAL TOTAL ECMO T1318 - ALL PATIENTS**



bysort YearOfService: keep if _n==1
browse

drop if annual_total_ECMO_T1318 ==.

tab annual_total_ECMO_T1318 YearOfService
tab annual_total_admissions_T1318 YearOfService

plot annual_total_admissions_T1318 YearOfService

reg annual_total_ECMO_T1318
reg annual_total_ECMO_T1318 YearOfService
reg annual_total_admissions_T1318
reg annual_total_admissions_T1318 YearOfService
reg annual_total_ECMO_T1318 YearOfService annual_total_admissions_T1318



*Generating Trauma Admissions - ALL HOSPITALS*

bysort obsnum: egen total_admissions_trauma = count(DischargeID) if (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6)
bysort HospitalNumber (total_admissions_trauma): replace total_admissions_trauma = total_admissions_trauma[1]

**Generating Not High Risk Admissions by Year Trauma - ALL Hospitals**
**GENERATING TOTAL ADMISSIONS BY YEAR **
*2016*
bysort obsnum: egen total_admissions_2016_trauma = count(DischargeID) if (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6) & YearOfService ==1 
sort total_admissions_2016_trauma 
replace total_admissions_2016_trauma = total_admissions_2016_trauma[1]

*2017*
bysort obsnum: egen total_admissions_2017_trauma = count(DischargeID) if (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6) & YearOfService ==2 
sort total_admissions_2017_trauma 
replace total_admissions_2017_trauma = total_admissions_2017_trauma[1]

*2018*
bysort obsnum: egen total_admissions_2018_trauma = count(DischargeID) if (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6) & YearOfService ==3 
sort total_admissions_2018_trauma 
replace total_admissions_2018_trauma = total_admissions_2018_trauma[1]

*2019*
bysort obsnum: egen total_admissions_2019_trauma = count(DischargeID) if (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6) & YearOfService ==4 
sort total_admissions_2019_trauma 
replace total_admissions_2019_trauma = total_admissions_2019_trauma[1]

*2020*
bysort obsnum: egen total_admissions_2020_trauma = count(DischargeID) if (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6) & YearOfService ==5 
sort total_admissions_2020_trauma 
replace total_admissions_2020_trauma = total_admissions_2020_trauma[1]

*2021*
bysort obsnum: egen total_admissions_2021_trauma = count(DischargeID) if (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6) & YearOfService ==6 
sort total_admissions_2021_trauma 
replace total_admissions_2021_trauma = total_admissions_2021_trauma[1]

*2022*
bysort obsnum: egen total_admissions_2022_trauma = count(DischargeID) if (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6) & YearOfService ==7 
sort total_admissions_2022_trauma 
replace total_admissions_2022_trauma = total_admissions_2022_trauma[1]

*2023*
bysort obsnum: egen total_admissions_2023_trauma = count(DischargeID) if (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6) & YearOfService ==8 
sort total_admissions_2023_trauma 
replace total_admissions_2023_trauma = total_admissions_2023_trauma[1]

*2024*
bysort obsnum: egen total_admissions_2024_trauma = count(DischargeID) if (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6) & YearOfService ==8 
sort total_admissions_2024_trauma 
replace total_admissions_2024_trauma = total_admissions_2024_trauma[1]


*generating annual total admissions variable trauma*
gen annual_total_admissions_trauma = .

*2016
bysort DischargeID: replace annual_total_admissions_trauma = total_admissions_2016_trauma if YearOfService ==1 
bysort DischargeID: replace annual_total_admissions_trauma = annual_total_admissions_trauma[1]

*2017*
bysort DischargeID: replace annual_total_admissions_trauma = total_admissions_2017_trauma if YearOfService ==2 
bysort DischargeID: replace annual_total_admissions_trauma = annual_total_admissions_trauma[1]

*2018
bysort DischargeID: replace annual_total_admissions_trauma = total_admissions_2018_trauma if YearOfService ==3 
bysort DischargeID: replace annual_total_admissions_trauma = annual_total_admissions_trauma[1]

*2019*
bysort DischargeID: replace annual_total_admissions_trauma = total_admissions_2019_trauma if YearOfService ==4 
bysort DischargeID: replace annual_total_admissions_trauma = annual_total_admissions_trauma[1]

*2020*
bysort DischargeID: replace annual_total_admissions_trauma = total_admissions_2020_trauma if YearOfService ==5 
bysort DischargeID: replace annual_total_admissions_trauma = annual_total_admissions_trauma[1]

*2021*
bysort DischargeID: replace annual_total_admissions_trauma = total_admissions_2021_trauma if YearOfService ==6 
bysort DischargeID: replace annual_total_admissions_trauma = annual_total_admissions_trauma[1]

*2022*
bysort DischargeID: replace annual_total_admissions_trauma = total_admissions_2022_trauma if YearOfService ==7 
bysort DischargeID: replace annual_total_admissions_trauma = annual_total_admissions_trauma[1]

*2023*
bysort DischargeID: replace annual_total_admissions_trauma = total_admissions_2023_trauma if YearOfService ==8 
bysort DischargeID: replace annual_total_admissions_trauma = annual_total_admissions_trauma[1]

*2024*
bysort DischargeID: replace annual_total_admissions_trauma = total_admissions_2024_trauma if YearOfService ==9 
bysort DischargeID: replace annual_total_admissions_trauma = annual_total_admissions_trauma[1]



**GENERATING TOTAL ECMO CASES Trauma BY YEAR - ALL CENTERS**
*2016 ECMO Cases*
bysort obsnum: egen total_ECMO_2016_trauma = count(DischargeID) if ECMO_y_n == 1 & (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6) & YearOfService ==1 
sort total_ECMO_2016_trauma
replace total_ECMO_2016_trauma = total_ECMO_2016_trauma[1]

*2017 ECMO Cases*
bysort obsnum: egen total_ECMO_2017_trauma = count(DischargeID) if ECMO_y_n == 1 & (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6) & YearOfService ==2 
sort total_ECMO_2017_trauma
replace total_ECMO_2017_trauma = total_ECMO_2017_trauma[1]


*2018 ECMO Cases*
bysort obsnum: egen total_ECMO_2018_trauma = count(DischargeID) if ECMO_y_n == 1 & (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6) & YearOfService ==3 
sort total_ECMO_2018_trauma
replace total_ECMO_2018_trauma = total_ECMO_2018_trauma[1]

*2019 ECMO Cases*
bysort obsnum: egen total_ECMO_2019_trauma = count(DischargeID) if ECMO_y_n == 1 & (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6) & YearOfService ==4 
sort total_ECMO_2019_trauma
replace total_ECMO_2019_trauma = total_ECMO_2019_trauma[1]


*2020 ECMO Cases*
bysort obsnum: egen total_ECMO_2020_trauma = count(DischargeID) if ECMO_y_n == 1 & (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6) & YearOfService ==5 
sort total_ECMO_2020_trauma
replace total_ECMO_2020_trauma = total_ECMO_2020_trauma[1]


*2021 ECMO Cases*
bysort obsnum: egen total_ECMO_2021_trauma = count(DischargeID) if ECMO_y_n == 1 & (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6) & YearOfService ==6 
sort total_ECMO_2021_trauma
replace total_ECMO_2021_trauma = total_ECMO_2021_trauma[1]


*2022 ECMO Cases*
bysort obsnum: egen total_ECMO_2022_trauma = count(DischargeID) if ECMO_y_n == 1 & (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6) & YearOfService ==7 
sort total_ECMO_2022_trauma
replace total_ECMO_2022_trauma = total_ECMO_2022_trauma[1]

*2023 ECMO Cases*
bysort obsnum: egen total_ECMO_2023_trauma = count(DischargeID) if ECMO_y_n == 1 & (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6) & YearOfService ==8 
sort total_ECMO_2023_trauma
replace total_ECMO_2023_trauma = total_ECMO_2023_trauma[1]


*2024 ECMO Cases*
bysort obsnum: egen total_ECMO_2024_trauma = count(DischargeID) if ECMO_y_n == 1 & (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6) & YearOfService ==9 
sort total_ECMO_2024_trauma
replace total_ECMO_2024_trauma = total_ECMO_2024_trauma[1]




**GENERATING TOTAL TRAUMA ECMO CASES BY YEAR**
gen annual_total_ECMO_trauma =.

replace annual_total_ECMO_trauma = total_ECMO_2016_trauma if YearOfService ==1 
replace annual_total_ECMO_trauma = total_ECMO_2017_trauma if YearOfService ==2 
replace annual_total_ECMO_trauma = total_ECMO_2018_trauma if YearOfService ==3
replace annual_total_ECMO_trauma = total_ECMO_2019_trauma if YearOfService ==4 
replace annual_total_ECMO_trauma = total_ECMO_2020_trauma if YearOfService ==5 
replace annual_total_ECMO_trauma = total_ECMO_2021_trauma if YearOfService ==6 
replace annual_total_ECMO_trauma = total_ECMO_2022_trauma if YearOfService ==7 
replace annual_total_ECMO_trauma = total_ECMO_2023_trauma if YearOfService ==8 
replace annual_total_ECMO_trauma = total_ECMO_2024_trauma if YearOfService ==9 



**GENERATING SINGLE VARIABLE REGRESSION FOR ANNUAL TRAUMA TOTAL ECMO - ALL PATIENTS**


bysort YearOfService: keep if _n==1
browse

drop if annual_total_ECMO_trauma ==.

tab annual_total_ECMO_trauma YearOfService
tab annual_total_admissions_trauma YearOfService 

reg annual_total_ECMO_trauma
reg annual_total_admissions_trauma
reg annual_total_admissions_trauma YearOfService
reg annual_total_ECMO_trauma YearOfService annual_total_admissions_trauma




*Generating Onc Admissions - ALL HOSPITALS*

bysort obsnum: egen total_admissions_onc = count(DischargeID) if (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6)
bysort HospitalNumber (total_admissions_onc): replace total_admissions_onc = total_admissions_onc[1]

**Generating Onc Admissions by Year - ALL Hospitals**
**Generating Not High Risk Admissions by Year - ALL Hospitals**
**GENERATING TOTAL ADMISSIONS BY YEAR **
*2016*
bysort obsnum: egen total_admissions_2016_onc = count(DischargeID) if (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6) & YearOfService ==1 
sort total_admissions_2016_onc 
replace total_admissions_2016_onc = total_admissions_2016_onc[1]

*2017*
bysort obsnum: egen total_admissions_2017_onc = count(DischargeID) if (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6) & YearOfService ==2 
sort total_admissions_2017_onc 
replace total_admissions_2017_onc = total_admissions_2017_onc[1]

*2018*
bysort obsnum: egen total_admissions_2018_onc = count(DischargeID) if (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6) & YearOfService ==3 
sort total_admissions_2018_onc 
replace total_admissions_2018_onc = total_admissions_2018_onc[1]

*2019*
bysort obsnum: egen total_admissions_2019_onc = count(DischargeID) if (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6) & YearOfService ==4 
sort total_admissions_2019_onc 
replace total_admissions_2019_onc = total_admissions_2019_onc[1]

*2020*
bysort obsnum: egen total_admissions_2020_onc = count(DischargeID) if (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6) & YearOfService ==5 
sort total_admissions_2020_onc 
replace total_admissions_2020_onc = total_admissions_2020_onc[1]

*2021*
bysort obsnum: egen total_admissions_2021_onc = count(DischargeID) if (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6) & YearOfService ==6 
sort total_admissions_2021_onc 
replace total_admissions_2021_onc = total_admissions_2021_onc[1]

*2022*
bysort obsnum: egen total_admissions_2022_onc = count(DischargeID) if (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6) & YearOfService ==7 
sort total_admissions_2022_onc 
replace total_admissions_2022_onc = total_admissions_2022_onc[1]

*2023*
bysort obsnum: egen total_admissions_2023_onc = count(DischargeID) if (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6) & YearOfService ==8 
sort total_admissions_2023_onc 
replace total_admissions_2023_onc = total_admissions_2023_onc[1]

*2024*
bysort obsnum: egen total_admissions_2024_onc = count(DischargeID) if (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6) & YearOfService ==8 
sort total_admissions_2024_onc 
replace total_admissions_2024_onc = total_admissions_2024_onc[1]

**generating annual total admissions variable onc**
gen annual_total_admissions_onc = .

*2016
bysort DischargeID: replace annual_total_admissions_onc = total_admissions_2016_onc if YearOfService ==1 
bysort DischargeID: replace annual_total_admissions_onc = annual_total_admissions_onc[1]

*2017*
bysort DischargeID: replace annual_total_admissions_onc = total_admissions_2017_onc if YearOfService ==2 
bysort DischargeID: replace annual_total_admissions_onc = annual_total_admissions_onc[1]

*2018
bysort DischargeID: replace annual_total_admissions_onc = total_admissions_2018_onc if YearOfService ==3
bysort DischargeID: replace annual_total_admissions_onc = annual_total_admissions_onc[1]

*2019*
bysort DischargeID: replace annual_total_admissions_onc = total_admissions_2019_onc if YearOfService ==4 
bysort DischargeID: replace annual_total_admissions_onc = annual_total_admissions_onc[1]

*2020*
bysort DischargeID: replace annual_total_admissions_onc = total_admissions_2020_onc if YearOfService ==5 
bysort DischargeID: replace annual_total_admissions_onc = annual_total_admissions_onc[1]

*2021*
bysort DischargeID: replace annual_total_admissions_onc = total_admissions_2021_onc if YearOfService ==6 
bysort DischargeID: replace annual_total_admissions_onc = annual_total_admissions_onc[1]

*2022*
bysort DischargeID: replace annual_total_admissions_onc = total_admissions_2022_onc if YearOfService ==7 
bysort DischargeID: replace annual_total_admissions_onc = annual_total_admissions_onc[1]

*2023*
bysort DischargeID: replace annual_total_admissions_onc = total_admissions_2023_onc if YearOfService ==8 
bysort DischargeID: replace annual_total_admissions_onc = annual_total_admissions_onc[1]

*2024*
bysort DischargeID: replace annual_total_admissions_onc = total_admissions_2024_onc if YearOfService ==9 
bysort DischargeID: replace annual_total_admissions_onc = annual_total_admissions_onc[1]

**GENERATING TOTAL ECMO CASES ONC BY YEAR - ALL CENTERS**
*2016 ECMO Cases*
bysort obsnum: egen total_ECMO_2016_onc = count(DischargeID) if ECMO_y_n == 1 & (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6) & YearOfService ==1 
sort total_ECMO_2016_onc
replace total_ECMO_2016_onc = total_ECMO_2016_onc[1]

*2017 ECMO Cases*
bysort obsnum: egen total_ECMO_2017_onc = count(DischargeID) if ECMO_y_n == 1 & (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6) & YearOfService ==2 
sort total_ECMO_2017_onc
replace total_ECMO_2017_onc = total_ECMO_2017_onc[1]


*2018 ECMO Cases*
bysort obsnum: egen total_ECMO_2018_onc = count(DischargeID) if ECMO_y_n == 1 & (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6) & YearOfService ==3 
sort total_ECMO_2018_onc
replace total_ECMO_2018_onc = total_ECMO_2018_onc[1]

*2019 ECMO Cases*
bysort obsnum: egen total_ECMO_2019_onc = count(DischargeID) if ECMO_y_n == 1 & (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6) & YearOfService ==4 
sort total_ECMO_2019_onc
replace total_ECMO_2019_onc = total_ECMO_2019_onc[1]


*2020 ECMO Cases*
bysort obsnum: egen total_ECMO_2020_onc = count(DischargeID) if ECMO_y_n == 1 & (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6) & YearOfService ==5 
sort total_ECMO_2020_onc
replace total_ECMO_2020_onc = total_ECMO_2020_onc[1]


*2021 ECMO Cases*
bysort obsnum: egen total_ECMO_2021_onc = count(DischargeID) if ECMO_y_n == 1 & (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6) & YearOfService ==6 
sort total_ECMO_2021_onc
replace total_ECMO_2021_onc = total_ECMO_2021_onc[1]


*2022 ECMO Cases*
bysort obsnum: egen total_ECMO_2022_onc = count(DischargeID) if ECMO_y_n == 1 & (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6) & YearOfService ==7 
sort total_ECMO_2022_onc
replace total_ECMO_2022_onc = total_ECMO_2022_onc[1]

*2023 ECMO Cases*
bysort obsnum: egen total_ECMO_2023_onc = count(DischargeID) if ECMO_y_n == 1 & (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6) & YearOfService ==8 
sort total_ECMO_2023_onc
replace total_ECMO_2023_onc = total_ECMO_2023_onc[1]


*2024 ECMO Cases*
bysort obsnum: egen total_ECMO_2024_onc = count(DischargeID) if ECMO_y_n == 1 & (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6) & YearOfService ==9 
sort total_ECMO_2024_onc
replace total_ECMO_2024_onc = total_ECMO_2024_onc[1]




**GENERATING TOTAL ONC ECMO CASES BY YEAR**
gen annual_total_ECMO_onc =.

replace annual_total_ECMO_onc = total_ECMO_2016_onc if YearOfService ==1 
replace annual_total_ECMO_onc = total_ECMO_2017_onc if YearOfService ==2 
replace annual_total_ECMO_onc = total_ECMO_2018_onc if YearOfService ==3
replace annual_total_ECMO_onc = total_ECMO_2019_onc if YearOfService ==4 
replace annual_total_ECMO_onc = total_ECMO_2020_onc if YearOfService ==5 
replace annual_total_ECMO_onc = total_ECMO_2021_onc if YearOfService ==6 
replace annual_total_ECMO_onc = total_ECMO_2022_onc if YearOfService ==7 
replace annual_total_ECMO_onc = total_ECMO_2023_onc if YearOfService ==8 
replace annual_total_ECMO_onc = total_ECMO_2024_onc if YearOfService ==9 




**GENERATING SINGLE VARIABLE REGRESSION FOR ANNUAL ONC TOTAL ECMO - ALL PATIENTS**



bysort YearOfService: keep if _n==1
browse

drop if annual_total_ECMO_onc ==.

tab annual_total_ECMO_onc YearOfService
tab annual_total_admissions_onc YearOfService

reg annual_total_admissions_onc
reg annual_total_admissions_onc YearOfService

reg annual_total_ECMO_onc
reg annual_total_ECMO_onc YearOfService annual_total_admissions_onc


browse
**GENERATING NO-ECMO MORTALITY BY RISK GROUP**
**overall no ECMO mortality count**
bysort DischargeID: egen no_ECMO_mortality_count_all = count(DischargeID) if ECMO_y_n ==0 & mortality ==1
sort no_ECMO_mortality_count_all
replace no_ECMO_mortality_count_all = no_ECMO_mortality_count_all[1]

**overall no ECMO mortality count not-high risk risk**
bysort DischargeID: egen no_ECMO_mortality_count_nhr = count(DischargeID) if ECMO_y_n ==0 & mortality ==1 & high_risk_group ==3
sort no_ECMO_mortality_count_nhr
replace no_ECMO_mortality_count_nhr = no_ECMO_mortality_count_nhr[1]


**overall no ECMO mortality count trisomy 13/18 risk**
bysort DischargeID: egen no_ECMO_mortality_count_T1318 = count(DischargeID) if ECMO_y_n ==0 & mortality ==1 & (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5)
sort no_ECMO_mortality_count_T1318
replace no_ECMO_mortality_count_T1318 = no_ECMO_mortality_count_T1318[1]

**overall no ECMO mortality count trauma**
bysort DischargeID: egen no_ECMO_mortality_count_trauma = count(DischargeID) if ECMO_y_n ==0 & mortality ==1 & (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6)
sort no_ECMO_mortality_count_trauma
replace no_ECMO_mortality_count_trauma = no_ECMO_mortality_count_trauma[1]

**overall no ECMO mortality count onc**
bysort DischargeID: egen no_ECMO_mortality_count_onc = count(DischargeID) if ECMO_y_n ==0 & mortality ==1 & (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6)
sort no_ECMO_mortality_count_onc
replace no_ECMO_mortality_count_onc = no_ECMO_mortality_count_onc[1]




**GENERATING ECMO MORTALITY BY RISK GROUP**
*overall ECMO mortality count*
bysort DischargeID: egen ECMO_mortality_count_all = count(DischargeID) if ECMO_y_n ==1 & mortality ==1
sort ECMO_mortality_count_all
replace ECMO_mortality_count_all = ECMO_mortality_count_all[1]

*overall ECMO mortality count not-high risk*
bysort DischargeID: egen ECMO_mortality_count_nhr = count(DischargeID) if ECMO_y_n ==1 & mortality ==1 & high_risk_group ==3
sort ECMO_mortality_count_nhr
replace ECMO_mortality_count_nhr = ECMO_mortality_count_nhr[1]

*overall ECMO mortality count trisomy 13/8 risk*
bysort DischargeID: egen ECMO_mortality_count_T1318 = count(DischargeID) if ECMO_y_n ==1 & mortality ==1 & (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5)
sort ECMO_mortality_count_T1318
replace ECMO_mortality_count_T1318 = ECMO_mortality_count_T1318[1]

*overall ECMO mortality count trauma*
bysort DischargeID: egen ECMO_mortality_count_trauma = count(DischargeID) if ECMO_y_n ==1 & mortality ==1 & (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6)
sort ECMO_mortality_count_trauma
replace ECMO_mortality_count_trauma = ECMO_mortality_count_trauma[1]

*overall ECMO mortality count onc*
bysort DischargeID: egen ECMO_mortality_count_onc = count(DischargeID) if ECMO_y_n ==1 & mortality ==1 & (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6)
sort ECMO_mortality_count_onc
replace ECMO_mortality_count_onc = ECMO_mortality_count_onc[1]


drop if HospitalNumber ==.
drop if DischargeID ==.

**Table 1**

tab ECMO_y_n Ethnicity, chi2
tab ECMO_y_n Gender, chi2
tab ECMO_y_n high_risk_group, chi2
tab mortality high_risk_group if ECMO_y_n ==0, chi2


~pause

**Table 1 data**

bysort YearOfService: keep if _n ==1
browse YearOfService annual_total_ECMO annual_total_ECMO_T1318 annual_total_ECMO_T1318 annual_total_ECMO_trauma annual_total_ECMO_onc annual_total_ECMO_nhr
browse YearOfService annual_total_admissions annual_total_admissions_T1318 annual_total_admissions_trauma annual_total_admissions_onc annual_total_admissions_nhr



**Table 1 Data All Hospital Data**


bysort YearOfService(obsnum): keep if _n==1

tab annual_total_ECMO YearOfService, chi2
tab annual_total_admissions YearOfService, chi2
tab annual_total_ECMO annual_total_admissions, exact

codebook annual_total_admissions
codebook annual_total_ECMO

sum annual_total_admissions
sum annual_total_ECMO

reg annual_total_admissions
reg annual_total_admissions YearOfService

reg annual_total_ECMO
reg annual_total_ECMO YearOfService annual_total_admissions




**Table 1 Data All Hospital Data - Not High Risk**

bysort YearOfService(obsnum): keep if _n==1

tab annual_total_ECMO_nhr YearOfService, chi2
tab annual_total_admissions_nhr YearOfService, chi2
tab annual_total_ECMO_nhr annual_total_admissions_nhr, exact

codebook annual_total_admissions_nhr
codebook annual_total_ECMO_nhr

sum annual_total_admissions_nhr
sum annual_total_ECMO_nhr

reg annual_total_admissions_nhr
reg annual_total_admissions YearOfService

reg annual_total_ECMO_nhr
reg annual_total_ECMO_nhr YearOfService annual_total_admissions_nhr


**Table 1 Data All Hospital Data – Trisomy 13/18**


bysort YearOfService(obsnum): keep if _n==1

tab annual_total_ECMO_T1318 YearOfService, chi2
tab annual_total_admissions_T1318 YearOfService, chi2
tab annual_total_ECMO_T1318 annual_total_admissions_T1318, exact

codebook annual_total_admissions_T1318
codebook annual_total_ECMO_T1318

sum annual_total_admissions_T1318
sum annual_total_ECMO_T1318

reg annual_total_admissions_T1318
reg annual_total_admissions YearOfService

reg annual_total_ECMO_T1318
reg annual_total_ECMO_T1318 YearOfService annual_total_admissions_T1318


**Table 1 Data All Hospital Data – Trauma**


bysort YearOfService(obsnum): keep if _n==1

tab annual_total_ECMO_trauma YearOfService, chi2
tab annual_total_admissions_trauma YearOfService, chi2
tab annual_total_ECMO_trauma annual_total_admissions_trauma, exact

codebook annual_total_admissions_trauma
codebook annual_total_ECMO_trauma

sum annual_total_admissions_trauma
sum annual_total_ECMO_trauma

reg annual_total_admissions_trauma
reg annual_total_admissions YearOfService

reg annual_total_ECMO_trauma
reg annual_total_ECMO_trauma YearOfService annual_total_admissions_trauma

**Table 1 Data All Hospital Data –Onc/HSCT**

bysort YearOfService(obsnum): keep if _n==1

tab annual_total_ECMO_onc YearOfService, chi2
tab annual_total_admissions_onc YearOfService, chi2
tab annual_total_ECMO_onc annual_total_admissions_onc, exact

codebook annual_total_admissions_onc
codebook annual_total_ECMO_onc

sum annual_total_admissions_onc
sum annual_total_ECMO_onc

reg annual_total_admissions_onc
reg annual_total_admissions YearOfService

reg annual_total_ECMO_onc
reg annual_total_ECMO_onc YearOfService annual_total_admissions_onc


mean(annual_total_ECMO)
mean(annual_total_admissions)
~pause

bysort YearOfService: keep if _n==1
twoway ///
    (scatter annual_total_ECMO YearOfService, ///
        mlabel(annual_total_ECMO) mlabangle(45)) ///
    (scatter annual_total_admissions YearOfService, ///
        mlabel(annual_total_admissions) mlabangle(-45)), ///
    xtitle("Year") ///
    xlabel(1 "2016" 2 "2017" 3 "2018" 4 "2019" 5 "2020" ///
           6 "2021" 7 "2022" 8 "2023" 9 "2024", angle(-45)) ///
    ytitle("Number of Cases") ///
	yscale(log) ///
    legend(order(1 "Total ECMO (Mean = 1,209)" 2 "Total Admissions (Mean = 107,699)"))


mean(annual_total_ECMO_T1318)
mean(annual_total_admissions_T1318)

~pause
preserve
bysort YearOfService: keep if _n==1
twoway ///
    (scatter annual_total_ECMO_T1318 YearOfService, mlabel(annual_total_ECMO_T1318) mlabangle(45)) ///
    (scatter annual_total_admissions_T1318 YearOfService, mlabel(annual_total_admissions_T1318) mlabangle(-45)), ///
      xtitle("Year") ///
    xlabel(1 "2016" 2 "2017" 3 "2018" 4 "2019" 5 "2020" ///
           6 "2021" 7 "2022" 8 "2023" 9 "2024", angle(-45)) ///
    ytitle("Number of Cases") ///
    legend(order(1 "Total ECMO (Mean = 2)" 2 "Total Admissions (Mean = 419)"))


mean(annual_total_ECMO_trauma)
mean(annual_total_admissions_trauma)

~pause

bysort YearOfService: keep if _n==1 
twoway ///
    (scatter annual_total_ECMO_trauma YearOfService, mlabel(annual_total_ECMO_trauma) mlabangle(45)) ///
    (scatter annual_total_admissions_trauma YearOfService, mlabel(annual_total_admissions_trauma) mlabangle(-45)), ///
        xtitle("Year") ///
    xlabel(1 "2016" 2 "2017" 3 "2018" 4 "2019" 5 "2020" ///
           6 "2021" 7 "2022" 8 "2023" 9 "2024", angle(-45)) ///
    ytitle("Number of Cases") ///
    legend(order(1 "Total ECMO (Mean = 158)" 2 "Total Admissions (Mean = 7,852)"))


mean(annual_total_ECMO_onc)
mean(annual_total_admissions_onc)

~pause
preserve
bysort YearOfService: keep if _n==1 
twoway ///
    (scatter annual_total_ECMO_onc YearOfService, mlabel(annual_total_ECMO_onc) mlabangle(45)) ///
    (scatter annual_total_admissions_onc YearOfService, mlabel(annual_total_admissions_onc) mlabangle(-45)), ///
       xtitle("Year") ///
    xlabel(1 "2016" 2 "2017" 3 "2018" 4 "2019" 5 "2020" ///
           6 "2021" 7 "2022" 8 "2023" 9 "2024", angle(-45)) ///
    ytitle("Number of Cases") ///
    legend(order(1 "Total ECMO (Mean = 13)" 2 "Total Admissions (Mean = 3,947)"))


mean(annual_total_ECMO_nhr)
mean(annual_total_admissions_nhr)

~pause

bysort YearOfService: keep if _n==1 
twoway ///
    (scatter annual_total_ECMO_nhr YearOfService, mlabel(annual_total_ECMO_nhr) mlabangle(45)) ///
    (scatter annual_total_admissions_nhr YearOfService, mlabel(annual_total_admissions_nhr) mlabangle(-45)), ///
       xtitle("Year") ///
    xlabel(1 "2016" 2 "2017" 3 "2018" 4 "2019" 5 "2020" ///
           6 "2021" 7 "2022" 8 "2023" 9 "2024", angle(-45)) ///
    ytitle("Number of Cases") ///
    legend(order(1 "Total ECMO (Mean = 1,036)" 2 "Total Admissions (Mean = 95,963)"))

restore

preserve
bysort DischargeID: keep if _n==1
	
~pause
**REGRESSION**
*creation of empty model*
logistic ECMO_y_n
estimates store modele1 

*creation of level 1 model*
logistic ECMO_y_n ib3.high_risk_group ib0.ECMO_dx_y_n Ethnicity Gender admitageyears YearOfService 
estimates store model1a

*creation of empty model with fixed effects*
melogit ECMO_y_n||HospitalNumber: , or
estimates store modele2

*creation of multilevel model, fixed effects*
melogit ECMO_y_n ib3.high_risk_group i.Ethnicity i.Gender c.admitageyears c.YearOfService c.center_admissions c.center_totalecmo c.number_of_casesonc c.number_of_casest1318 c.number_of_casestrauma ||HospitalNumber: , or
estimates store model2a



margins, at(center_admissions = (10000(5000)30000))
margins, at(center_totalecmo = (200(100)1000))

restore

**MARGINS ECMO_dx_y_n**

margins, at (ECMO_dx_y_n = 1)


**MARGINS T1318**
*margins center admissions*
margins, at(center_admissions = (10000(1000)30000) high_risk_group = 0 ECMO_dx_y_n = 1 center_totalecmo = 361.6644 number_of_casesonc = 930.8248 number_of_casest1318 = 98.29036  number_of_casestrauma = 1803.592)

melogit , nolog
*margins center total ecmo*
margins, at (center_totalecmo = (100(50)500) high_risk_group = 0 ECMO_dx_y_n = 1 center_admissions = 19750.05 number_of_casesonc = 930.8248 number_of_casest1318 = 98.29036  number_of_casestrauma = 1803.592)

**MARGINS Trauma**
melogit , nolog
*margins center admissions*
margins, at (center_admissions = (10000(1000)30000) high_risk_group = 1 ECMO_dx_y_n = 1 center_totalecmo = 361.6644 number_of_casesonc = 930.8248 number_of_casest1318 = 98.29036  number_of_casestrauma = 1803.592)

melogit , nolog
*margins center total ecmo*
margins, at (center_totalecmo = (100(50)500) high_risk_group = 1 ECMO_dx_y_n = 1 center_admissions = 19750.05 number_of_casesonc = 930.8248 number_of_casest1318 = 98.29036  number_of_casestrauma = 1803.592)

**MARGINS ONC**
melogit , nolog
*margins center admissions*
margins, at (center_admissions = (10000(1000)30000) high_risk_group = 2 ECMO_dx_y_n = 1 center_totalecmo = 361.6644 number_of_casesonc = 930.8248 number_of_casest1318 = 98.29036  number_of_casestrauma = 1803.592)

melogit , nolog
*margins center total ecmo*
margins, at (center_totalecmo = (100(50)500) high_risk_group = 2 ECMO_dx_y_n = 1 center_admissions = 19750.05 number_of_casesonc = 930.8248 number_of_casest1318 = 98.29036  number_of_casestrauma = 1803.592)

*creation of multilevel model, random effects*
melogit ECMO_y_n ib3.high_risk_group ib0.ECMO_dx_y_n Ethnicity Gender admitageyears YearOfService center_admissions center_totalecmo number_of_casesonc number_of_casest1318 number_of_casestrauma ||HospitalNumber: ib3.high_risk_group , or
estimates store model3


bysort YearOfService: keep if _n==1
browse YearOfService total_admissions annual_total_admissions

tab ECMO_dx_y_n high_risk_group

**--**

**Total Patients**
codebook DischargeID

tab YearOfService ECMO_y_n if (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5) 

**Total ECLS Patients**
codebook DischargeID if ECMO_y_n ==1
**Total ECLS Patients-T13/18**
codebook DischargeID if ECMO_y_n ==1 & (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5)
**Total ECLS Patients-Trauma**
codebook DischargeID if ECMO_y_n ==1 & (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6)
**Total ECLS Patients-Onc/HSCT**
codebook DischargeID if ECMO_y_n ==1 & (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6)
**Total ECLS Patients-Not High Risk**
codebook DischargeID if ECMO_y_n ==1 & high_risk_group ==3

~pause

**Total non-ECLS Patients**
codebook DischargeID if ECMO_y_n ==0
**Total ECLS Patients-T13/18**
codebook DischargeID if ECMO_y_n ==0 & (high_risk_group ==0 | high_risk_group == 4 | high_risk_group ==5)
**Total ECLS Patients-Trauma**
codebook DischargeID if ECMO_y_n ==0 & (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6)
**Total ECLS Patients-Onc/HSCT**
codebook DischargeID if ECMO_y_n ==0 & (high_risk_group ==2 | high_risk_group == 5 | high_risk_group ==6)
**Total ECLS Patients-Not High Risk**
codebook DischargeID if ECMO_y_n ==0 & high_risk_group ==3

**Patient Age**
tab admitageyears ECMO_y_n
ttest admitageyears, by(ECMO_y_n)

**Patient Ethnicity**
tab Ethnicity ECMO_y_n, chi2

**Patient Gender**
tab Gender ECMO_y_n , chi2

**Patient Diagnostic Group**
tab high_risk_group ECMO_y_n , chi2

**Patient Mortality Rate no-ECMO**
tabstat mortality if ECMO_y_n ==0, by (high_risk_group) 

**Patient Mortality Rate ECMO**
tab mortality if ECMO_y_n ==1, by (high_risk_group) 

bysort DischargeID: keep if ECMO_y_n ==1
tab mortality high_risk_group, chi2


**2016 trauma mortality count**
drop mortality_2016_trauma
bysort DischargeID: egen mortality_2016_trauma = count(DischargeID) if (high_risk_group ==1 | high_risk_group == 4 | high_risk_group ==6) & ECMO_y_n ==1 & mortality ==1 & YearOfService == 1
**2016 mortality rate**
drop p_mortality_2016_trauma
bysort DischargeID: gen p_mortality_2016_trauma = mortality_2016_trauma/total_ECMO_2016_trauma

**Mortality**

bysort YearOfService: keep if _n==1
reg mortality_rate YearOfService



melogit ECMO_y_n ib3.high_risk_group i.Ethnicity i.Gender c.admitageyears c.YearOfService c.center_admissions c.center_totalecmo c.number_of_casesonc c.number_of_casest1318 c.number_of_casestrauma ||HospitalNumber: , or coeflegend


**probabilities**
*baseline*
di .0073738/(.0073738 + 1) * 100
*High Risk Groups*
*T13/18 probability*
di .0073738*.4882429 /(.0073738*.4882429 + 1) * 100
*Trauma probability*
di .0073738*2.137313 /(.0073738*2.137313 + 1) * 100
*Onc probability*
di .0073738*.3458533 /(.0073738*.3458533 + 1) * 100

**CI**
*High Risk Groups*
*baseline*
*lower*
di .0059978 / (.0059978 +1)*100
*upper*
di .0090655/ (.0090655 + 1)*100
*T1318 CI*
*lower*
di .0073738*.3142088 /(.0073738*.3142088  + 1) * 100
*upper*
di .0073738*.7586709 /(.0073738*.7586709 + 1) * 100

*Trauma CI*
*lower*
di .0073738*2.014383 /(.0073738*2.014383 + 1) * 100
*upper*
di .0073738*2.267746 /(.0073738*2.267746 + 1) * 100

*Onc/HSCT*
*lower*
di .0073738*.2853401 /(.0073738*.2853401 + 1) * 100
*upper*
di .0073738*.4191997 /(.0073738*.4191997 + 1) * 100

ssc install table1
table1, by(ECMO_y_n) vars(admitageyears contn \ Ethnicity cat \ high_risk_group cat Gender cat \ Mortality cat)

table1, by(ecmo_type1) vars(high_risk_group cat)


