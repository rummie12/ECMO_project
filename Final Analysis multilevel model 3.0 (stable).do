clear

use "C:\Users\laxfr\Desktop\All-Comers\Onc-BMT\Stata\Data\All Admitted Onc-BMT Modified Table 1 Data (Updated).dta"

append using "C:\Users\laxfr\Desktop\All-Comers\Trisomy\Stata\Data\All Trisomy Patients Modified Table 1 (Updated).dta"

append using "C:\Users\laxfr\Desktop\All-Comers\Trauma\Stata\Data\All Trauma Patients Modified Table 1 (Updated).dta"

browse

merge m:m DischargeID using "C:\Users\laxfr\Desktop\All-Comers\All Patients\Stata\Data\All High Patients with ECMO Dx All Table 1 (Updated).dta"

rename _merge _merge_all

merge m:m DischargeID using "C:\Users\laxfr\Desktop\Fellowship Files\CHEAR Fellowship\Research\ECMO Practica 1\Data\All Hospital\Stata\Data\All ECMO Cases pulled by Px and Date.dta"

rename _merge _merge_ecmo

tab high_risk_group high_risk_group

replace high_risk_group =3 if high_risk_group ==.

tab high_risk_group high_risk_group

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

*generate first encounter*
bysort DischargeID: gen first= _n==1
drop if first ==0


**TOTAL ADMISSIONS**
*generating total admissions by center*
bysort HospitalNumber: egen center_admissions = count(DischargeID)
bysort HospitalNumber (center_admissions): replace center_admissions = center_admissions[1]

**TOTAL ECMO**
*generating total number of ecmo cases by center*
bysort HospitalNumber: egen center_totalecmo = sum(ECMO_y_n) if first ==1
bysort HospitalNumber (DischargeID): replace center_totalecmo = center_totalecmo[1]

**ADMITS BY HIGH RISK GROUP**
*generating number of onc/bmt cases by center*
bysort HospitalNumber: egen number_of_casesonc = count(DischargeID) if first ==1 & high_risk_group ==2
bysort HospitalNumber (number_of_casesonc): replace number_of_casesonc = number_of_casesonc[1]

*generating number of t13/18 cases by center*
bysort HospitalNumber: egen number_of_casest1318 = count(DischargeID) if first ==1 & high_risk_group ==0
bysort HospitalNumber (number_of_casest1318): replace number_of_casest1318 = number_of_casest1318[1]

*generating number of trauma cases by center*
bysort HospitalNumber: egen number_of_casestrauma = count(DischargeID) if first ==1 & high_risk_group ==1
bysort HospitalNumber (number_of_casestrauma): replace number_of_casestrauma = number_of_casestrauma[1]

**TRAUMA ECMO**

*generating number of ECMO by trauma 2016*
bysort HospitalNumber: egen ecmo_cases_trauma_2016 = count(DischargeID) if high_risk_group ==1 & ECMO_y_n == 1 & YearOfService == 2016
bysort HospitalNumber (ecmo_cases_trauma_2016): replace ecmo_cases_trauma_2016 = ecmo_cases_trauma_2016[1]

*generating number of ECMO by trauma 2017*
bysort HospitalNumber: egen ecmo_cases_trauma_2017 = count(DischargeID) if high_risk_group ==1 & ECMO_y_n == 1 & YearOfService == 2017
bysort HospitalNumber (ecmo_cases_trauma_2017): replace ecmo_cases_trauma_2017 = ecmo_cases_trauma_2017[1]

*generating number of ECMO by trauma 2018*
bysort HospitalNumber: egen ecmo_cases_trauma_2018 = count(DischargeID) if high_risk_group ==1 & ECMO_y_n == 1 & YearOfService == 2018
bysort HospitalNumber (ecmo_cases_trauma_2018): replace ecmo_cases_trauma_2018 = ecmo_cases_trauma_2018[1]

*generating number of ECMO by trauma 2019*
bysort HospitalNumber: egen ecmo_cases_trauma_2019 = count(DischargeID) if high_risk_group ==1 & ECMO_y_n == 1 & YearOfService == 2019
bysort HospitalNumber (ecmo_cases_trauma_2019): replace ecmo_cases_trauma_2019 = ecmo_cases_trauma_2019[1]

*generating number of ECMO by trauma 2020*
bysort HospitalNumber: egen ecmo_cases_trauma_2020 = count(DischargeID) if high_risk_group ==1 & ECMO_y_n == 1 & YearOfService == 2020
bysort HospitalNumber (ecmo_cases_trauma_2020): replace ecmo_cases_trauma_2020 = ecmo_cases_trauma_2020[1]

*generating number of ECMO by trauma 2021*
bysort HospitalNumber: egen ecmo_cases_trauma_2021 = count(DischargeID) if high_risk_group ==1 & ECMO_y_n == 1 & YearOfService == 2021
bysort HospitalNumber (ecmo_cases_trauma_2021): replace ecmo_cases_trauma_2021 = ecmo_cases_trauma_2021[1]

*generating number of ECMO by trauma 2022*
bysort HospitalNumber: egen ecmo_cases_trauma_2022 = count(DischargeID) if high_risk_group ==1 & ECMO_y_n == 1 & YearOfService == 2022
bysort HospitalNumber (ecmo_cases_trauma_2022): replace ecmo_cases_trauma_2022 = ecmo_cases_trauma_2022[1]

*generating number of ECMO by trauma 2023*
bysort HospitalNumber: egen ecmo_cases_trauma_2023 = count(DischargeID) if high_risk_group ==1 & ECMO_y_n == 1 & YearOfService == 2023
bysort HospitalNumber (ecmo_cases_trauma_2016): replace ecmo_cases_trauma_2023 = ecmo_cases_trauma_2023[1]

*generating number of ECMO by trauma 2024*
bysort HospitalNumber: egen ecmo_cases_trauma_2024 = count(DischargeID) if high_risk_group ==1 & ECMO_y_n == 1 & YearOfService == 2024
bysort HospitalNumber (ecmo_cases_trauma_2024): replace ecmo_cases_trauma_2024 = ecmo_cases_trauma_2024[1]

**TRISOMY ECMO**
*generating number of ECMO by trisomy 2016*
bysort HospitalNumber: egen ecmo_cases_trisomy_2016 = count(DischargeID) if high_risk_group ==0 & ECMO_y_n == 1 & YearOfService == 2016
bysort HospitalNumber (ecmo_cases_trisomy_2016): replace ecmo_cases_trisomy_2016 = ecmo_cases_trisomy_2016[1]

*generating number of ECMO by trisomy 2017*
bysort HospitalNumber: egen ecmo_cases_trisomy_2017 = count(DischargeID) if high_risk_group ==0 & ECMO_y_n == 1 & YearOfService == 2017
bysort HospitalNumber (ecmo_cases_trisomy_2017): replace ecmo_cases_trisomy_2017 = ecmo_cases_trisomy_2017[1]

*generating number of ECMO by trisomy 2018*
bysort HospitalNumber: egen ecmo_cases_trisomy_2018 = count(DischargeID) if high_risk_group ==0 & ECMO_y_n == 1 & YearOfService == 2018
bysort HospitalNumber (ecmo_cases_trisomy_2018): replace ecmo_cases_trisomy_2018 = ecmo_cases_trisomy_2018[1]

*generating number of ECMO by trisomy 2019*
bysort HospitalNumber: egen ecmo_cases_trisomy_2019 = count(DischargeID) if high_risk_group ==0 & ECMO_y_n == 1 & YearOfService == 2019
bysort HospitalNumber (ecmo_cases_trisomy_2019): replace ecmo_cases_trisomy_2019 = ecmo_cases_trisomy_2019[1]

*generating number of ECMO by trisomy 2020*
bysort HospitalNumber: egen ecmo_cases_trisomy_2020 = count(DischargeID) if high_risk_group ==0 & ECMO_y_n == 1 & YearOfService == 2020
bysort HospitalNumber (ecmo_cases_trisomy_2020): replace ecmo_cases_trisomy_2020 = ecmo_cases_trisomy_2020[1]

*generating number of ECMO by trisomy 2021*
bysort HospitalNumber: egen ecmo_cases_trisomy_2021 = count(DischargeID) if high_risk_group ==0 & ECMO_y_n == 1 & YearOfService == 2021
bysort HospitalNumber (ecmo_cases_trisomy_2021): replace ecmo_cases_trisomy_2021 = ecmo_cases_trisomy_2021[1]

*generating number of ECMO by trisomy 2022*
bysort HospitalNumber: egen ecmo_cases_trisomy_2022 = count(DischargeID) if high_risk_group ==0 & ECMO_y_n == 1 & YearOfService == 2022
bysort HospitalNumber (ecmo_cases_trisomy_2022): replace ecmo_cases_trisomy_2022 = ecmo_cases_trisomy_2022[1]

*generating number of ECMO by trisomy 2023*
bysort HospitalNumber: egen ecmo_cases_trisomy_2023 = count(DischargeID) if high_risk_group ==0 & ECMO_y_n == 1 & YearOfService == 2023
bysort HospitalNumber (ecmo_cases_trisomy_2016): replace ecmo_cases_trisomy_2023 = ecmo_cases_trisomy_2023[1]

*generating number of ECMO by trisomy 2024*
bysort HospitalNumber: egen ecmo_cases_trisomy_2024 = count(DischargeID) if high_risk_group ==0 & ECMO_y_n == 1 & YearOfService == 2024
bysort HospitalNumber (ecmo_cases_trisomy_2024): replace ecmo_cases_trisomy_2024 = ecmo_cases_trisomy_2024[1]

**ONC ECMO**
*generating number of ECMO by onc 2016*
bysort HospitalNumber: egen ecmo_cases_onc_2016 = count(DischargeID) if high_risk_group ==2 & ECMO_y_n == 1 & YearOfService == 2016
bysort HospitalNumber (ecmo_cases_onc_2016): replace ecmo_cases_onc_2016 = ecmo_cases_onc_2016[1]

*generating number of ECMO by onc 2017*
bysort HospitalNumber: egen ecmo_cases_onc_2017 = count(DischargeID) if high_risk_group ==2 & ECMO_y_n == 1 & YearOfService == 2017
bysort HospitalNumber (ecmo_cases_onc_2017): replace ecmo_cases_onc_2017 = ecmo_cases_onc_2017[1]

*generating number of ECMO by onc 2018*
bysort HospitalNumber: egen ecmo_cases_onc_2018 = count(DischargeID) if high_risk_group ==2 & ECMO_y_n == 1 & YearOfService == 2018
bysort HospitalNumber (ecmo_cases_onc_2018): replace ecmo_cases_onc_2018 = ecmo_cases_onc_2018[1]

*generating number of ECMO by onc 2019*
bysort HospitalNumber: egen ecmo_cases_onc_2019 = count(DischargeID) if high_risk_group ==2 & ECMO_y_n == 1 & YearOfService == 2019
bysort HospitalNumber (ecmo_cases_onc_2019): replace ecmo_cases_onc_2019 = ecmo_cases_onc_2019[1]

*generating number of ECMO by onc 2020*
bysort HospitalNumber: egen ecmo_cases_onc_2020 = count(DischargeID) if high_risk_group ==2 & ECMO_y_n == 1 & YearOfService == 2020
bysort HospitalNumber (ecmo_cases_onc_2020): replace ecmo_cases_onc_2020 = ecmo_cases_onc_2020[1]

*generating number of ECMO by onc 2021*
bysort HospitalNumber: egen ecmo_cases_onc_2021 = count(DischargeID) if high_risk_group ==2 & ECMO_y_n == 1 & YearOfService == 2021
bysort HospitalNumber (ecmo_cases_onc_2021): replace ecmo_cases_onc_2021 = ecmo_cases_onc_2021[1]

*generating number of ECMO by onc 2022*
bysort HospitalNumber: egen ecmo_cases_onc_2022 = count(DischargeID) if high_risk_group ==2 & ECMO_y_n == 1 & YearOfService == 2022
bysort HospitalNumber (ecmo_cases_onc_2022): replace ecmo_cases_onc_2022 = ecmo_cases_onc_2022[1]

*generating number of ECMO by onc 2023*
bysort HospitalNumber: egen ecmo_cases_onc_2023 = count(DischargeID) if high_risk_group ==2 & ECMO_y_n == 1 & YearOfService == 2023
bysort HospitalNumber (ecmo_cases_onc_2016): replace ecmo_cases_onc_2023 = ecmo_cases_onc_2023[1]

*generating number of ECMO by onc 2024*
bysort HospitalNumber: egen ecmo_cases_onc_2024 = count(DischargeID) if high_risk_group ==2 & ECMO_y_n == 1 & YearOfService == 2024
bysort HospitalNumber (ecmo_cases_onc_2024): replace ecmo_cases_onc_2024 = ecmo_cases_onc_2024[1]

**NOT HIGH RISK ECMO**
*generating number of ECMO by not_high_risk 2016*
bysort HospitalNumber: egen ecmo_cases_not_high_risk_2016 = count(DischargeID) if high_risk_group ==3 & ECMO_y_n == 1 & YearOfService == 2016
bysort HospitalNumber (ecmo_cases_not_high_risk_2016): replace ecmo_cases_not_high_risk_2016 = ecmo_cases_not_high_risk_2016[1]

*generating number of ECMO by not_high_risk 2017*
bysort HospitalNumber: egen ecmo_cases_not_high_risk_2017 = count(DischargeID) if high_risk_group ==3 & ECMO_y_n == 1 & YearOfService == 2017
bysort HospitalNumber (ecmo_cases_not_high_risk_2017): replace ecmo_cases_not_high_risk_2017 = ecmo_cases_not_high_risk_2017[1]

*generating number of ECMO by not_high_risk 2018*
bysort HospitalNumber: egen ecmo_cases_not_high_risk_2018 = count(DischargeID) if high_risk_group ==3 & ECMO_y_n == 1 & YearOfService == 2018
bysort HospitalNumber (ecmo_cases_not_high_risk_2018): replace ecmo_cases_not_high_risk_2018 = ecmo_cases_not_high_risk_2018[1]

*generating number of ECMO by not_high_risk 2019*
bysort HospitalNumber: egen ecmo_cases_not_high_risk_2019 = count(DischargeID) if high_risk_group ==3 & ECMO_y_n == 1 & YearOfService == 2019
bysort HospitalNumber (ecmo_cases_not_high_risk_2019): replace ecmo_cases_not_high_risk_2019 = ecmo_cases_not_high_risk_2019[1]

*generating number of ECMO by not_high_risk 2020*
bysort HospitalNumber: egen ecmo_cases_not_high_risk_2020 = count(DischargeID) if high_risk_group ==3 & ECMO_y_n == 1 & YearOfService == 2020
bysort HospitalNumber (ecmo_cases_not_high_risk_2020): replace ecmo_cases_not_high_risk_2020 = ecmo_cases_not_high_risk_2020[1]

*generating number of ECMO by not_high_risk 2021*
bysort HospitalNumber: egen ecmo_cases_not_high_risk_2021 = count(DischargeID) if high_risk_group ==3 & ECMO_y_n == 1 & YearOfService == 2021
bysort HospitalNumber (ecmo_cases_not_high_risk_2021): replace ecmo_cases_not_high_risk_2021 = ecmo_cases_not_high_risk_2021[1]

*generating number of ECMO by not_high_risk 2022*
bysort HospitalNumber: egen ecmo_cases_not_high_risk_2022 = count(DischargeID) if high_risk_group ==3 & ECMO_y_n == 1 & YearOfService == 2022
bysort HospitalNumber (ecmo_cases_not_high_risk_2022): replace ecmo_cases_not_high_risk_2022 = ecmo_cases_not_high_risk_2022[1]

*generating number of ECMO by not_high_risk 2023*
bysort HospitalNumber: egen ecmo_cases_not_high_risk_2023 = count(DischargeID) if high_risk_group ==3 & ECMO_y_n == 1 & YearOfService == 2023
bysort HospitalNumber (ecmo_cases_not_high_risk_2016): replace ecmo_cases_not_high_risk_2023 = ecmo_cases_not_high_risk_2023[1]

*generating number of ECMO by not_high_risk 2024*
bysort HospitalNumber: egen ecmo_cases_not_high_risk_2024 = count(DischargeID) if high_risk_group ==3 & ECMO_y_n == 1 & YearOfService == 2024
bysort HospitalNumber (ecmo_cases_not_high_risk_2024): replace ecmo_cases_not_high_risk_2024 = ecmo_cases_not_high_risk_2024[1]


**ADMISSIONS BY YEAR**

*generating number of admissions by year (2016)*
bysort HospitalNumber: egen center_admissions_2016= count(DischargeID) if AdmitYear == 2016
bysort HospitalNumber (center_admissions_2016): replace center_admissions_2016= center_admissions_2016[1]

*generating number of admissions by year (2017)*
bysort HospitalNumber: egen center_admissions_2017= count(DischargeID) if AdmitYear == 2017
bysort HospitalNumber (center_admissions_2017): replace center_admissions_2017 = center_admissions_2017[1]

*generating number of admissions by year (2018)*
bysort HospitalNumber: egen center_admissions_2018= count(DischargeID) if AdmitYear == 2018
bysort HospitalNumber (center_admissions_2018): replace center_admissions_2018 = center_admissions_2018[1]

*generating number of admissions by year (2019)*
bysort HospitalNumber: egen center_admissions_2019= count(DischargeID) if AdmitYear == 2019
bysort HospitalNumber (center_admissions_2019): replace center_admissions_2019 = center_admissions_2019[1]

*generating number of admissions by year (2020)*
bysort HospitalNumber: egen center_admissions_2020= count(DischargeID) if AdmitYear == 2020
bysort HospitalNumber (center_admissions_2020): replace center_admissions_2020 = center_admissions_2020[1]

*generating number of admissions by year (2021)*
bysort HospitalNumber: egen center_admissions_2021= count(DischargeID) if AdmitYear == 2021
bysort HospitalNumber (center_admissions_2021): replace center_admissions_2021 = center_admissions_2021[1]

*generating number of admissions by year (2022)*
bysort HospitalNumber: egen center_admissions_2022= count(DischargeID) if AdmitYear == 2022
bysort HospitalNumber (center_admissions_2022): replace center_admissions_2022 = center_admissions_2022[1]

*generating number of admissions by year (2023)*
bysort HospitalNumber: egen center_admissions_2023= count(DischargeID) if AdmitYear == 2023
bysort HospitalNumber (center_admissions_2023): replace center_admissions_2023= center_admissions_2023[1]

*generating number of admissions by year (2024)*
bysort HospitalNumber: egen center_admissions_2024= count(DischargeID) if AdmitYear == 2024
bysort HospitalNumber (center_admissions_2024): replace center_admissions_2024 = center_admissions_2024[1]


**ECMO CASES BY YEAR**

*generating number of ecmo cases by year (2016)*
bysort HospitalNumber: egen center_total_ecmo_2016= count(DischargeID) if YearOfService == 2016 & ECMO_y_n ==1
bysort HospitalNumber (center_total_ecmo_2016): replace center_total_ecmo_2016= center_total_ecmo_2016[1]

*generating number of ecmo cases by year (2017)*
bysort HospitalNumber: egen center_total_ecmo_2017= count(DischargeID) if YearOfService == 2017 & ECMO_y_n ==1
bysort HospitalNumber (center_total_ecmo_2017): replace center_total_ecmo_2017= center_total_ecmo_2017[1]

*generating number of ecmo cases by year (2018)*
bysort HospitalNumber: egen center_total_ecmo_2018= count(DischargeID) if YearOfService == 2018 & ECMO_y_n ==1
bysort HospitalNumber (center_total_ecmo_2018): replace center_total_ecmo_2018= center_total_ecmo_2018[1]

*generating number of ecmo cases by year (2019)*
bysort HospitalNumber: egen center_total_ecmo_2019= count(DischargeID) if YearOfService == 2019 & ECMO_y_n ==1
bysort HospitalNumber (center_total_ecmo_2019): replace center_total_ecmo_2019= center_total_ecmo_2019[1]

*generating number of ecmo cases by year (2020)*
bysort HospitalNumber: egen center_total_ecmo_2020= count(DischargeID) if YearOfService == 2020 & ECMO_y_n ==1
bysort HospitalNumber (center_total_ecmo_2020): replace center_total_ecmo_2020 = center_total_ecmo_2020[1]

*generating number of ecmo cases by year (2021)*
bysort HospitalNumber: egen center_total_ecmo_2021= count(DischargeID) if YearOfService == 2021 & ECMO_y_n ==1
bysort HospitalNumber (center_total_ecmo_2021): replace center_total_ecmo_2021 = center_total_ecmo_2021[1]

*generating number of ecmo cases by year (2022)*
bysort HospitalNumber: egen center_total_ecmo_2022= count(DischargeID) if YearOfService == 2022 & ECMO_y_n ==1
bysort HospitalNumber (center_total_ecmo_2022): replace center_total_ecmo_2022 = center_total_ecmo_2022[1]

*generating number of ecmo cases by year (2023)*
bysort HospitalNumber: egen center_total_ecmo_2023= count(DischargeID) if YearOfService == 2023 & ECMO_y_n ==1
bysort HospitalNumber (center_total_ecmo_2023): replace center_total_ecmo_2023 = center_total_ecmo_2023[1]

*generating number of ecmo cases by year (2024)*
bysort HospitalNumber: egen center_total_ecmo_2024= count(DischargeID) if YearOfService == 2024 & ECMO_y_n ==1
bysort HospitalNumber (center_total_ecmo_2024): replace center_total_ecmo_2024 = center_total_ecmo_2024[1]

*generating mean number of admissions*
egen mean_center_admissions = mean(center_admissions)

*generating mean number of ecmo cases*
egen mean_center_totalecmo = mean(center_totalecmo)

*generating mean number of t13/t18 admissions*
egen mean_number_of_casest1318 = mean(number_of_casest1318)

*generating mean number of trauma admissions*
egen mean_number_of_casestrauma = mean(number_of_casestrauma)

*generating mean number of onc admissions*
egen mean_number_of_casesonc = mean(number_of_casesonc)

*Generating Trisomy 13/18 Admissions - ALL HOSPITALS*

egen total_admissions_T1318 = count(DischargeID) if high_risk_group ==0
bysort HospitalNumber (total_admissions_T1318): replace total_admissions_T1318 = total_admissions_T1318[1]

**Generating Trisomy 13/18 Admissions by Year - ALL Hospitals**
*2016*
egen total_admissions_T1318_2016 = count(DischargeID) if high_risk_group ==0 & AdmitYear == 2016
bysort HospitalNumber (total_admissions_T1318_2016): replace total_admissions_T1318_2016 = total_admissions_T1318_2016[1]

*2017*
egen total_admissions_T1318_2017 = count(DischargeID) if high_risk_group ==0 & AdmitYear == 2017
bysort HospitalNumber (total_admissions_T1318_2017): replace total_admissions_T1318_2017 = total_admissions_T1318_2017[1]

*2018*
egen total_admissions_T1318_2018 = count(DischargeID) if high_risk_group ==0 & AdmitYear == 2018
bysort HospitalNumber (total_admissions_T1318_2018): replace total_admissions_T1318_2018 = total_admissions_T1318_2018[1]

*2019*
egen total_admissions_T1318_2019 = count(DischargeID) if high_risk_group ==0 & AdmitYear == 2019
bysort HospitalNumber (total_admissions_T1318_2019): replace total_admissions_T1318_2019 = total_admissions_T1318_2019[1]

*2020*
egen total_admissions_T1318_2020 = count(DischargeID) if high_risk_group ==0 & AdmitYear == 2020
bysort HospitalNumber (total_admissions_T1318_2020): replace total_admissions_T1318_2020 = total_admissions_T1318_2020[1]

*2021*
egen total_admissions_T1318_2021 = count(DischargeID) if high_risk_group ==0 & AdmitYear == 2021
bysort HospitalNumber (total_admissions_T1318_2021): replace total_admissions_T1318_2021 = total_admissions_T1318_2021[1]

*2022*
egen total_admissions_T1318_2022 = count(DischargeID) if high_risk_group ==0 & AdmitYear == 2022
bysort HospitalNumber (total_admissions_T1318_2022): replace total_admissions_T1318_2022 = total_admissions_T1318_2022[1]

*2023*
egen total_admissions_T1318_2023 = count(DischargeID) if high_risk_group ==0 & AdmitYear == 2023
bysort HospitalNumber (total_admissions_T1318_2023): replace total_admissions_T1318_2023 = total_admissions_T1318_2023[1]

*2024*
egen total_admissions_T1318_2024 = count(DischargeID) if high_risk_group ==0 & AdmitYear == 2024
bysort HospitalNumber (total_admissions_T1318_2024): replace total_admissions_T1318_2024 = total_admissions_T1318_2024[1]

*Generating Trauma Admissions - ALL HOSPITALS*

egen total_admissionstrauma = count(DischargeID) if high_risk_group ==1
bysort HospitalNumber (total_admissionstrauma): replace total_admissionstrauma = total_admissionstrauma[1]

**Generating Trauma Admissions by Year - ALL Hospitals**
*2016*
egen total_admissions_trauma_2016 = count(DischargeID) if high_risk_group ==1 & AdmitYear == 2016
bysort HospitalNumber (total_admissions_trauma_2016): replace total_admissions_trauma_2016 = total_admissions_trauma_2016[1]

*2017*
egen total_admissions_trauma_2017 = count(DischargeID) if high_risk_group ==1 & AdmitYear == 2017
bysort HospitalNumber (total_admissions_trauma_2017): replace total_admissions_trauma_2017 = total_admissions_trauma_2017[1]

*2018*
egen total_admissions_trauma_2018 = count(DischargeID) if high_risk_group ==1 & AdmitYear == 2018
bysort HospitalNumber (total_admissions_trauma_2018): replace total_admissions_trauma_2018 = total_admissions_trauma_2018[1]

*2019*
egen total_admissions_trauma_2019 = count(DischargeID) if high_risk_group ==1 & AdmitYear == 2019
bysort HospitalNumber (total_admissions_trauma_2019): replace total_admissions_trauma_2019 = total_admissions_trauma_2019[1]

*2020*
egen total_admissions_trauma_2020 = count(DischargeID) if high_risk_group ==1 & AdmitYear == 2020
bysort HospitalNumber (total_admissions_trauma_2020): replace total_admissions_trauma_2020 = total_admissions_trauma_2020[1]

*2021*
egen total_admissions_trauma_2021 = count(DischargeID) if high_risk_group ==1 & AdmitYear == 2021
bysort HospitalNumber (total_admissions_trauma_2021): replace total_admissions_trauma_2021 = total_admissions_trauma_2021[1]

*2022*
egen total_admissions_trauma_2022 = count(DischargeID) if high_risk_group ==1 & AdmitYear == 2022
bysort HospitalNumber (total_admissions_trauma_2022): replace total_admissions_trauma_2022 = total_admissions_trauma_2022[1]

*2023*
egen total_admissions_trauma_2023 = count(DischargeID) if high_risk_group ==1 & AdmitYear == 2023
bysort HospitalNumber (total_admissions_trauma_2023): replace total_admissions_trauma_2023 = total_admissions_trauma_2023[1]

*2024*
egen total_admissions_trauma_2024 = count(DischargeID) if high_risk_group ==1 & AdmitYear == 2024
bysort HospitalNumber (total_admissions_trauma_2024): replace total_admissions_trauma_2024 = total_admissions_trauma_2024[1]

*Generating Onc Admissions - ALL HOSPITALS*

egen total_admissionsonc = count(DischargeID) if high_risk_group ==2
bysort HospitalNumber (total_admissionsonc): replace total_admissionsonc = total_admissionsonc[1]

**Generating Onc Admissions by Year - ALL Hospitals**
*2016*
egen total_admissions_onc_2016 = count(DischargeID) if high_risk_group ==2 & AdmitYear == 2016
bysort HospitalNumber (total_admissions_onc_2016): replace total_admissions_onc_2016 = total_admissions_onc_2016[1]

*2017*
egen total_admissions_onc_2017 = count(DischargeID) if high_risk_group ==2 & AdmitYear == 2017
bysort HospitalNumber (total_admissions_onc_2017): replace total_admissions_onc_2017 = total_admissions_onc_2017[1]

*2018*
egen total_admissions_onc_2018 = count(DischargeID) if high_risk_group ==2 & AdmitYear == 2018
bysort HospitalNumber (total_admissions_onc_2018): replace total_admissions_onc_2018 = total_admissions_onc_2018[1]

*2019*
egen total_admissions_onc_2019 = count(DischargeID) if high_risk_group ==2 & AdmitYear == 2019
bysort HospitalNumber (total_admissions_onc_2019): replace total_admissions_onc_2019 = total_admissions_onc_2019[1]

*2020*
egen total_admissions_onc_2020 = count(DischargeID) if high_risk_group ==2 & AdmitYear == 2020
bysort HospitalNumber (total_admissions_onc_2020): replace total_admissions_onc_2020 = total_admissions_onc_2020[1]

*2021*
egen total_admissions_onc_2021 = count(DischargeID) if high_risk_group ==2 & AdmitYear == 2021
bysort HospitalNumber (total_admissions_onc_2021): replace total_admissions_onc_2021 = total_admissions_onc_2021[1]

*2022*
egen total_admissions_onc_2022 = count(DischargeID) if high_risk_group ==2 & AdmitYear == 2022
bysort HospitalNumber (total_admissions_onc_2022): replace total_admissions_onc_2022 = total_admissions_onc_2022[1]

*2023*
egen total_admissions_onc_2023 = count(DischargeID) if high_risk_group ==2 & AdmitYear == 2023
bysort HospitalNumber (total_admissions_onc_2023): replace total_admissions_onc_2023 = total_admissions_onc_2023[1]

*2024*
egen total_admissions_onc_2024 = count(DischargeID) if high_risk_group ==2 & AdmitYear == 2024
bysort HospitalNumber (total_admissions_onc_2024): replace total_admissions_onc_2024 = total_admissions_onc_2024[1]

*Generating Not High Risk Admissions - ALL HOSPITALS*

egen total_admissions_not_hr = count(DischargeID) if high_risk_group ==3
bysort HospitalNumber (total_admissions_not_hr): replace total_admissions_not_hr = total_admissions_not_hr[1]

**Generating Not High Risk Admissions by Year - ALL Hospitals**
*2016*
egen total_admissions_not_hr_2016 = count(DischargeID) if high_risk_group ==3 & AdmitYear == 2016
bysort HospitalNumber (total_admissions_not_hr_2016): replace total_admissions_not_hr_2016 = total_admissions_not_hr_2016[1]

*2017*
egen total_admissions_not_hr_2017 = count(DischargeID) if high_risk_group ==3 & AdmitYear == 2017
bysort HospitalNumber (total_admissions_not_hr_2017): replace total_admissions_not_hr_2017 = total_admissions_not_hr_2017[1]

*2018*
egen total_admissions_not_hr_2018 = count(DischargeID) if high_risk_group ==3 & AdmitYear == 2018
bysort HospitalNumber (total_admissions_not_hr_2018): replace total_admissions_not_hr_2018 = total_admissions_not_hr_2018[1]

*2019*
egen total_admissions_not_hr_2019 = count(DischargeID) if high_risk_group ==3 & AdmitYear == 2019
bysort HospitalNumber (total_admissions_not_hr_2019): replace total_admissions_not_hr_2019 = total_admissions_not_hr_2019[1]

*2020*
egen total_admissions_not_hr_2020 = count(DischargeID) if high_risk_group ==3 & AdmitYear == 2020
bysort HospitalNumber (total_admissions_not_hr_2020): replace total_admissions_not_hr_2020 = total_admissions_not_hr_2020[1]

*2021*
egen total_admissions_not_hr_2021 = count(DischargeID) if high_risk_group ==3 & AdmitYear == 2021
bysort HospitalNumber (total_admissions_not_hr_2021): replace total_admissions_not_hr_2021 = total_admissions_not_hr_2021[1]

*2022*
egen total_admissions_not_hr_2022 = count(DischargeID) if high_risk_group ==3 & AdmitYear == 2022
bysort HospitalNumber (total_admissions_not_hr_2022): replace total_admissions_not_hr_2022 = total_admissions_not_hr_2022[1]

*2023*
egen total_admissions_not_hr_2023 = count(DischargeID) if high_risk_group ==3 & AdmitYear == 2023
bysort HospitalNumber (total_admissions_not_hr_2023): replace total_admissions_not_hr_2023 = total_admissions_not_hr_2023[1]

*2024*
egen total_admissions_not_hr_2024 = count(DischargeID) if high_risk_group ==3 & AdmitYear == 2024
bysort HospitalNumber (total_admissions_not_hr_2024): replace total_admissions_not_hr_2024 = total_admissions_not_hr_2024[1]

*Generating Total Number of ECMO Cases - ALL CENTERS*
egen total_ECMO = sum(ECMO_y_n)

**GENERATING TOTAL ECMO CASES BY YEAR - ALL CENTERS**
*2016 ECMO Cases*
egen total_ECMO_2016 = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2016
bysort HospitalNumber (total_ECMO_2016): replace total_ECMO_2016 = total_ECMO_2016[1]

*2017 ECMO Cases*
egen total_ECMO_2017 = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2017
bysort HospitalNumber (total_ECMO_2017): replace total_ECMO_2017 = total_ECMO_2017[1]

*2018 ECMO Cases*
egen total_ECMO_2018 = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2018
bysort HospitalNumber (total_ECMO_2018): replace total_ECMO_2018 = total_ECMO_2018[1]

*2019 ECMO Cases*
egen total_ECMO_2019 = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2019
bysort HospitalNumber (total_ECMO_2019): replace total_ECMO_2019 = total_ECMO_2019[1]

*2020 ECMO Cases*
egen total_ECMO_2020 = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2020
bysort HospitalNumber (total_ECMO_2020): replace total_ECMO_2020 = total_ECMO_2020[1]

*2021 ECMO Cases*
egen total_ECMO_2021 = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2021
bysort HospitalNumber (total_ECMO_2021): replace total_ECMO_2021 = total_ECMO_2021[1]


*2022 ECMO Cases*
egen total_ECMO_2022 = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2022
bysort HospitalNumber (total_ECMO_2022): replace total_ECMO_2022 = total_ECMO_2022[1]

*2023 ECMO Cases*
egen total_ECMO_2023 = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2023
bysort HospitalNumber (total_ECMO_2023): replace total_ECMO_2023 = total_ECMO_2023[1]

*2024 ECMO Cases*
egen total_ECMO_2024 = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2024
bysort HospitalNumber (total_ECMO_2024): replace total_ECMO_2024 = total_ECMO_2024[1]


**GENERATING TOTAL ECMO CASES BY YEAR**

bysort DischargeID: gen annual_total_ECMO = total_ECMO_2016 if YearOfService == 2016 
bysort YearOfService: replace annual_total_ECMO = annual_total_ECMO[1]
replace annual_total_ECMO = total_ECMO_2017 if YearOfService == 2017
bysort YearOfService: replace annual_total_ECMO = annual_total_ECMO[1]
replace annual_total_ECMO = total_ECMO_2018 if YearOfService == 2018
bysort YearOfService: replace annual_total_ECMO = annual_total_ECMO[1]
replace annual_total_ECMO = total_ECMO_2019 if YearOfService == 2019
bysort YearOfService: replace annual_total_ECMO = annual_total_ECMO[1]
replace annual_total_ECMO = total_ECMO_2020 if YearOfService == 2020
bysort YearOfService: replace annual_total_ECMO = annual_total_ECMO[1]
replace annual_total_ECMO = total_ECMO_2021 if YearOfService == 2021
bysort YearOfService: replace annual_total_ECMO = annual_total_ECMO[1]
replace annual_total_ECMO = total_ECMO_2022 if YearOfService == 2022
bysort YearOfService: replace annual_total_ECMO = annual_total_ECMO[1]
replace annual_total_ECMO = total_ECMO_2023 if YearOfService == 2023
bysort YearOfService: replace annual_total_ECMO = annual_total_ECMO[1]
replace annual_total_ECMO = total_ECMO_2024 if YearOfService == 2024
bysort YearOfService: replace annual_total_ECMO = annual_total_ECMO[1]

**GENERATING TOTAL ECMO CASES NOT HIGH RISK BY YEAR - ALL CENTERS**
*2016 ECMO Cases*
egen total_ECMO_2016_not_hr = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2016 & high_risk_group ==3
bysort total_ECMO_2016_not_hr: replace total_ECMO_2016_not_hr = total_ECMO_2016_not_hr[1]

*2017 ECMO Cases*
egen total_ECMO_2017_not_hr = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2017 & high_risk_group ==3
bysort total_ECMO_2017_not_hr: replace total_ECMO_2017_not_hr = total_ECMO_2017_not_hr[1]


*2018 ECMO Cases*
egen total_ECMO_2018_not_hr = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2018 & high_risk_group ==3
bysort total_ECMO_2018_not_hr: replace total_ECMO_2018_not_hr = total_ECMO_2018_not_hr[1]

*2019 ECMO Cases*
egen total_ECMO_2019_not_hr = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2019 & high_risk_group ==3
bysort total_ECMO_2019_not_hr: replace total_ECMO_2019_not_hr = total_ECMO_2019_not_hr[1]

*2020 ECMO Cases*
egen total_ECMO_2020_not_hr = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2020 & high_risk_group ==3
bysort total_ECMO_2020_not_hr: replace total_ECMO_2020_not_hr = total_ECMO_2020_not_hr[1]

*2021 ECMO Cases*
egen total_ECMO_2021_not_hr = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2021 & high_risk_group ==3
bysort total_ECMO_2021_not_hr: replace total_ECMO_2021_not_hr = total_ECMO_2021_not_hr[1]


*2022 ECMO Cases*
egen total_ECMO_2022_not_hr = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2022 & high_risk_group ==3
bysort total_ECMO_2022_not_hr: replace total_ECMO_2022_not_hr = total_ECMO_2022_not_hr[1]

*2023 ECMO Cases*
egen total_ECMO_2023_not_hr = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2023 & high_risk_group ==3
bysort total_ECMO_2023_not_hr: replace total_ECMO_2023_not_hr = total_ECMO_2023_not_hr[1]

*2024 ECMO Cases*
egen total_ECMO_2024_not_hr = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2024 & high_risk_group ==3
bysort total_ECMO_2024_not_hr: replace total_ECMO_2024_not_hr = total_ECMO_2024_not_hr[1]


**GENERATING TOTAL NOT HIGH RISK ECMO CASES BY YEAR**
gen annual_total_ECMO_not_hr =.

replace annual_total_ECMO_not_hr = total_ECMO_2016_not_hr if YearOfService == 2016
replace annual_total_ECMO_not_hr = total_ECMO_2017_not_hr if YearOfService == 2017
replace annual_total_ECMO_not_hr = total_ECMO_2018_not_hr if YearOfService == 2018
replace annual_total_ECMO_not_hr = total_ECMO_2019_not_hr if YearOfService == 2019
replace annual_total_ECMO_not_hr = total_ECMO_2020_not_hr if YearOfService == 2020
replace annual_total_ECMO_not_hr = total_ECMO_2021_not_hr if YearOfService == 2021
replace annual_total_ECMO_not_hr = total_ECMO_2022_not_hr if YearOfService == 2022
replace annual_total_ECMO_not_hr = total_ECMO_2023_not_hr if YearOfService == 2023
replace annual_total_ECMO_not_hr = total_ECMO_2024_not_hr if YearOfService == 2024



*generating annual total admissions variable Not High Risk*
gen annual_total_admissions_not_hr = .


*2016
bysort DischargeID: replace annual_total_admissions_not_hr = total_admissions_not_hr_2016 if AdmitYear == 2016
bysort AdmitYear: replace annual_total_admissions_not_hr = annual_total_admissions_not_hr[1]

*2017*
bysort DischargeID: replace annual_total_admissions_not_hr = total_admissions_not_hr_2017 if AdmitYear == 2017
bysort AdmitYear: replace annual_total_admissions_not_hr = annual_total_admissions_not_hr[1]

*2018
bysort DischargeID: replace annual_total_admissions_not_hr = total_admissions_not_hr_2018 if AdmitYear == 2018
bysort AdmitYear: replace annual_total_admissions_not_hr = annual_total_admissions_not_hr[1]

*2019*
bysort DischargeID: replace annual_total_admissions_not_hr = total_admissions_not_hr_2019 if AdmitYear == 2019
bysort AdmitYear: replace annual_total_admissions_not_hr = annual_total_admissions_not_hr[1]

*2020*
bysort DischargeID: replace annual_total_admissions_not_hr = total_admissions_not_hr_2020 if AdmitYear == 2020
bysort AdmitYear: replace annual_total_admissions_not_hr = annual_total_admissions_not_hr[1]

*2021*
bysort DischargeID: replace annual_total_admissions_not_hr = total_admissions_not_hr_2021 if AdmitYear == 2021
bysort AdmitYear: replace annual_total_admissions_not_hr = annual_total_admissions_not_hr[1]

*2022*
bysort DischargeID: replace annual_total_admissions_not_hr = total_admissions_not_hr_2022 if AdmitYear == 2022
bysort AdmitYear: replace annual_total_admissions_not_hr = annual_total_admissions_not_hr[1]

*2023*
bysort DischargeID: replace annual_total_admissions_not_hr = total_admissions_not_hr_2023 if AdmitYear == 2023
bysort AdmitYear: replace annual_total_admissions_not_hr = annual_total_admissions_not_hr[1]

*2024*
bysort DischargeID: replace annual_total_admissions_not_hr = total_admissions_not_hr_2024 if AdmitYear == 2024
bysort AdmitYear: replace annual_total_admissions_not_hr = annual_total_admissions_not_hr[1]


preserve

**GENERATING SINGLE VARIABLE REGRESSION FOR ANNUAL TRAUMA TOTAL ECMO - ALL PATIENTS**

bysort YearOfService (annual_total_ECMO_not_hr): keep if _n==1
browse

drop if annual_total_ECMO_not_hr ==.

tab annual_total_ECMO_not_hr AdmitYear
tab annual_total_admissions_not_hr AdmitYear

reg annual_total_ECMO_not_hr

reg annual_total_admissions_not_hr

reg annual_total_ECMO_not_hr YearOfService annual_total_admissions_not_hr

restore



**GENERATING TOTAL ECMO CASES TRISOMY 13/18 BY YEAR - ALL CENTERS**
*2016 ECMO Cases*
egen total_ECMO_2016_T1318 = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2016 & high_risk_group ==0
bysort total_ECMO_2016_T1318: replace total_ECMO_2016_T1318 = total_ECMO_2016_T1318[1]

*2017 ECMO Cases*
egen total_ECMO_2017_T1318 = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2017 & high_risk_group ==0
bysort total_ECMO_2017_T1318: replace total_ECMO_2017_T1318 = total_ECMO_2017_T1318[1]


*2018 ECMO Cases*
egen total_ECMO_2018_T1318 = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2018 & high_risk_group ==0
bysort total_ECMO_2018_T1318: replace total_ECMO_2018_T1318 = total_ECMO_2018_T1318[1]

*2019 ECMO Cases*
egen total_ECMO_2019_T1318 = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2019 & high_risk_group ==0
bysort total_ECMO_2019_T1318: replace total_ECMO_2019_T1318 = total_ECMO_2019_T1318[1]

*2020 ECMO Cases*
egen total_ECMO_2020_T1318 = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2020 & high_risk_group ==0
bysort total_ECMO_2020_T1318: replace total_ECMO_2020_T1318 = total_ECMO_2020_T1318[1]

*2021 ECMO Cases*
egen total_ECMO_2021_T1318 = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2021 & high_risk_group ==0
bysort total_ECMO_2021_T1318: replace total_ECMO_2021_T1318 = total_ECMO_2021_T1318[1]


*2022 ECMO Cases*
egen total_ECMO_2022_T1318 = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2022 & high_risk_group ==0
bysort total_ECMO_2022_T1318: replace total_ECMO_2022_T1318 = total_ECMO_2022_T1318[1]

*2023 ECMO Cases*
egen total_ECMO_2023_T1318 = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2023 & high_risk_group ==0
bysort total_ECMO_2023_T1318: replace total_ECMO_2023_T1318 = total_ECMO_2023_T1318[1]

*2024 ECMO Cases*
egen total_ECMO_2024_T1318 = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2024 & high_risk_group ==0
bysort total_ECMO_2024_T1318: replace total_ECMO_2024_T1318 = total_ECMO_2024_T1318[1]

**GENERATING TOTAL ECMO CASES Trauma BY YEAR - ALL CENTERS**
*2016 ECMO Cases*
egen total_ECMO_2016_trauma = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2016 & high_risk_group ==1
bysort total_ECMO_2016_trauma: replace total_ECMO_2016_trauma = total_ECMO_2016_trauma[1]

*2017 ECMO Cases*
egen total_ECMO_2017_trauma = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2017 & high_risk_group ==1
bysort total_ECMO_2017_trauma: replace total_ECMO_2017_trauma = total_ECMO_2017_trauma[1]

*2018 ECMO Cases*
egen total_ECMO_2018_trauma = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2018 & high_risk_group ==1
bysort total_ECMO_2018_trauma: replace total_ECMO_2018_trauma = total_ECMO_2018_trauma[1]

*2019 ECMO Cases*
egen total_ECMO_2019_trauma = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2019 & high_risk_group ==1
bysort total_ECMO_2019_trauma: replace total_ECMO_2019_trauma = total_ECMO_2019_trauma[1]

*2020 ECMO Cases*
egen total_ECMO_2020_trauma = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2020 & high_risk_group ==1
bysort total_ECMO_2020_trauma: replace total_ECMO_2020_trauma = total_ECMO_2020_trauma[1]

*2021 ECMO Cases*
egen total_ECMO_2021_trauma = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2021 & high_risk_group ==1
bysort total_ECMO_2021_trauma: replace total_ECMO_2021_trauma = total_ECMO_2021_trauma[1]


*2022 ECMO Cases*
egen total_ECMO_2022_trauma = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2022 & high_risk_group ==1
bysort total_ECMO_2022_trauma: replace total_ECMO_2022_trauma = total_ECMO_2022_trauma[1]

*2023 ECMO Cases*
egen total_ECMO_2023_trauma = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2023 & high_risk_group ==1
bysort total_ECMO_2023_trauma: replace total_ECMO_2023_trauma = total_ECMO_2023_trauma[1]

*2024 ECMO Cases*
egen total_ECMO_2024_trauma = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2024 & high_risk_group ==1
bysort total_ECMO_2024_trauma: replace total_ECMO_2024_trauma = total_ECMO_2024_trauma[1]

**GENERATING TOTAL ECMO CASES ONC BY YEAR - ALL CENTERS**
*2016 ECMO Cases*
egen total_ECMO_2016_onc = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2016 & high_risk_group ==2
bysort total_ECMO_2016_onc: replace total_ECMO_2016_onc = total_ECMO_2016_onc[1]

*2017 ECMO Cases*
egen total_ECMO_2017_onc = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2017 & high_risk_group ==2
bysort total_ECMO_2017_onc: replace total_ECMO_2017_onc = total_ECMO_2017_onc[1]

*2018 ECMO Cases*
egen total_ECMO_2018_onc = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2018 & high_risk_group ==2
bysort total_ECMO_2018_onc: replace total_ECMO_2018_onc = total_ECMO_2018_onc[1]

*2019 ECMO Cases*
egen total_ECMO_2019_onc = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2019 & high_risk_group ==2
bysort total_ECMO_2019_onc: replace total_ECMO_2019_onc = total_ECMO_2019_onc[1]

*2020 ECMO Cases*
egen total_ECMO_2020_onc = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2020 & high_risk_group ==2
bysort total_ECMO_2020_onc: replace total_ECMO_2020_onc = total_ECMO_2020_onc[1]

*2021 ECMO Cases*
egen total_ECMO_2021_onc = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2021 & high_risk_group ==2
bysort total_ECMO_2021_onc: replace total_ECMO_2021_onc = total_ECMO_2021_onc[1]


*2022 ECMO Cases*
egen total_ECMO_2022_onc = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2022 & high_risk_group ==2
bysort total_ECMO_2022_onc: replace total_ECMO_2022_onc = total_ECMO_2022_onc[1]

*2023 ECMO Cases*
egen total_ECMO_2023_onc = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2023 & high_risk_group ==2
bysort total_ECMO_2023_onc: replace total_ECMO_2023_onc = total_ECMO_2023_onc[1]

*2024 ECMO Cases*
egen total_ECMO_2024_onc = count(DischargeID) if ECMO_y_n == 1 & YearOfService == 2024 & high_risk_group ==2
bysort total_ECMO_2024_onc: replace total_ECMO_2024_onc = total_ECMO_2024_onc[1]



**GENERATING TOTAL TRAUMA ECMO CASES BY YEAR**
gen annual_total_ECMO_trauma =.

replace annual_total_ECMO_trauma = total_ECMO_2016_trauma if YearOfService == 2016
replace annual_total_ECMO_trauma = total_ECMO_2017_trauma if YearOfService == 2017
replace annual_total_ECMO_trauma = total_ECMO_2018_trauma if YearOfService == 2018
replace annual_total_ECMO_trauma = total_ECMO_2019_trauma if YearOfService == 2019
replace annual_total_ECMO_trauma = total_ECMO_2020_trauma if YearOfService == 2020
replace annual_total_ECMO_trauma = total_ECMO_2021_trauma if YearOfService == 2021
replace annual_total_ECMO_trauma = total_ECMO_2022_trauma if YearOfService == 2022
replace annual_total_ECMO_trauma = total_ECMO_2023_trauma if YearOfService == 2023
replace annual_total_ECMO_trauma = total_ECMO_2024_trauma if YearOfService == 2024

*generating annual total admissions variable trauma*
gen annual_total_admissions_trauma = .

*2016
bysort DischargeID: replace annual_total_admissions_trauma = total_admissions_trauma_2016 if AdmitYear == 2016
bysort AdmitYear: replace annual_total_admissions_trauma = annual_total_admissions_trauma[1]

*2017*
bysort DischargeID: replace annual_total_admissions_trauma = total_admissions_trauma_2017 if AdmitYear == 2017
bysort AdmitYear: replace annual_total_admissions_trauma = annual_total_admissions_trauma[1]

*2018
bysort DischargeID: replace annual_total_admissions_trauma = total_admissions_trauma_2018 if AdmitYear == 2018
bysort annual_total_admissions_trauma: replace annual_total_admissions_trauma = annual_total_admissions_trauma[1]

*2019*
bysort DischargeID: replace annual_total_admissions_trauma = total_admissions_trauma_2019 if AdmitYear == 2019
bysort annual_total_admissions_trauma: replace annual_total_admissions_trauma = annual_total_admissions_trauma[1]

*2020*
bysort DischargeID: replace annual_total_admissions_trauma = total_admissions_trauma_2020 if AdmitYear == 2020
bysort annual_total_admissions_trauma: replace annual_total_admissions_trauma = annual_total_admissions_trauma[1]

*2021*
bysort DischargeID: replace annual_total_admissions_trauma = total_admissions_trauma_2021 if AdmitYear == 2021
bysort annual_total_admissions_trauma: replace annual_total_admissions_trauma = annual_total_admissions_trauma[1]

*2022*
bysort DischargeID: replace annual_total_admissions_trauma = total_admissions_trauma_2022 if AdmitYear == 2022
bysort annual_total_admissions_trauma: replace annual_total_admissions_trauma = annual_total_admissions_trauma[1]

*2023*
bysort DischargeID: replace annual_total_admissions_trauma = total_admissions_trauma_2023 if AdmitYear == 2023
bysort annual_total_admissions_trauma: replace annual_total_admissions_trauma = annual_total_admissions_trauma[1]

*2024*
bysort DischargeID: replace annual_total_admissions_trauma = total_admissions_trauma_2024 if AdmitYear == 2024
bysort annual_total_admissions_trauma: replace annual_total_admissions_trauma = annual_total_admissions_trauma[1]

tab annual_total_admissions_trauma AdmitYear


preserve

**GENERATING SINGLE VARIABLE REGRESSION FOR ANNUAL TRAUMA TOTAL ECMO - ALL PATIENTS**

bysort YearOfService (annual_total_ECMO_trauma): keep if _n==1
browse

drop if annual_total_ECMO_trauma ==.

tab annual_total_ECMO_trauma AdmitYear
tab annual_total_admissions_trauma AdmitYear 

reg annual_total_ECMO_trauma
reg annual_total_admissions_trauma
reg annual_total_ECMO_trauma YearOfService annual_total_admissions_trauma

restore

**GENERATING TOTAL ONC ECMO CASES BY YEAR**
gen annual_total_ECMO_onc =.

replace annual_total_ECMO_onc = total_ECMO_2016_onc if YearOfService == 2016
replace annual_total_ECMO_onc = total_ECMO_2017_onc if YearOfService == 2017
replace annual_total_ECMO_onc = total_ECMO_2018_onc if YearOfService == 2018
replace annual_total_ECMO_onc = total_ECMO_2019_onc if YearOfService == 2019
replace annual_total_ECMO_onc = total_ECMO_2020_onc if YearOfService == 2020
replace annual_total_ECMO_onc = total_ECMO_2021_onc if YearOfService == 2021
replace annual_total_ECMO_onc = total_ECMO_2022_onc if YearOfService == 2022
replace annual_total_ECMO_onc = total_ECMO_2023_onc if YearOfService == 2023
replace annual_total_ECMO_onc = total_ECMO_2024_onc if YearOfService == 2024



**generating annual total admissions variable onc**
gen annual_total_admissions_onc = .

*2016
bysort DischargeID: replace annual_total_admissions_onc = total_admissions_onc_2016 if AdmitYear == 2016
bysort AdmitYear: replace annual_total_admissions_onc = annual_total_admissions_onc[1]

*2017*
bysort DischargeID: replace annual_total_admissions_onc = total_admissions_onc_2017 if AdmitYear == 2017
bysort AdmitYear: replace annual_total_admissions_onc = annual_total_admissions_onc[1]

*2018
bysort DischargeID: replace annual_total_admissions_onc = total_admissions_onc_2018 if AdmitYear == 2018
bysort annual_total_admissions_onc: replace annual_total_admissions_onc = annual_total_admissions_onc[1]

*2019*
bysort DischargeID: replace annual_total_admissions_onc = total_admissions_onc_2019 if AdmitYear == 2019
bysort annual_total_admissions_onc: replace annual_total_admissions_onc = annual_total_admissions_onc[1]

*2020*
bysort DischargeID: replace annual_total_admissions_onc = total_admissions_onc_2020 if AdmitYear == 2020
bysort annual_total_admissions_onc: replace annual_total_admissions_onc = annual_total_admissions_onc[1]

*2021*
bysort DischargeID: replace annual_total_admissions_onc = total_admissions_onc_2021 if AdmitYear == 2021
bysort annual_total_admissions_onc: replace annual_total_admissions_onc = annual_total_admissions_onc[1]

*2022*
bysort DischargeID: replace annual_total_admissions_onc = total_admissions_onc_2022 if AdmitYear == 2022
bysort annual_total_admissions_onc: replace annual_total_admissions_onc = annual_total_admissions_onc[1]

*2023*
bysort DischargeID: replace annual_total_admissions_onc = total_admissions_onc_2023 if AdmitYear == 2023
bysort annual_total_admissions_onc: replace annual_total_admissions_onc = annual_total_admissions_onc[1]

*2024*
bysort DischargeID: replace annual_total_admissions_onc = total_admissions_onc_2024 if AdmitYear == 2024
bysort annual_total_admissions_onc: replace annual_total_admissions_onc = annual_total_admissions_onc[1]

preserve

**GENERATING SINGLE VARIABLE REGRESSION FOR ANNUAL ONC TOTAL ECMO - ALL PATIENTS**

bysort YearOfService (annual_total_ECMO_onc): keep if _n==1
browse

drop if annual_total_ECMO_onc ==.

tab annual_total_ECMO_onc AdmitYear
tab annual_total_admissions_onc AdmitYear

reg annual_total_ECMO_onc
reg annual_total_ECMO_onc YearOfService annual_total_admissions_onc

restore

**GENERATING TOTAL TRISOMY 1318 ECMO CASES BY YEAR**
gen annual_total_ECMO_T1318 =.

replace annual_total_ECMO_T1318 = total_ECMO_2016_T1318 if YearOfService == 2016
replace annual_total_ECMO_T1318 = total_ECMO_2017_T1318 if YearOfService == 2017
replace annual_total_ECMO_T1318 = total_ECMO_2018_T1318 if YearOfService == 2018
replace annual_total_ECMO_T1318 = total_ECMO_2019_T1318 if YearOfService == 2019
replace annual_total_ECMO_T1318 = total_ECMO_2020_T1318 if YearOfService == 2020
replace annual_total_ECMO_T1318 = total_ECMO_2021_T1318 if YearOfService == 2021
replace annual_total_ECMO_T1318 = total_ECMO_2022_T1318 if YearOfService == 2022
replace annual_total_ECMO_T1318 = total_ECMO_2023_T1318 if YearOfService == 2023
replace annual_total_ECMO_T1318 = total_ECMO_2024_T1318 if YearOfService == 2024

*generating annual total admissions variable t13/18*
gen annual_total_admissions_T1318 = .

*2016
bysort DischargeID: replace annual_total_admissions_T1318 = total_admissions_T1318_2016 if AdmitYear == 2016
bysort AdmitYear: replace annual_total_admissions_T1318 = annual_total_admissions_T1318[1]

*2017*
bysort DischargeID: replace annual_total_admissions_T1318 = total_admissions_T1318_2017 if AdmitYear == 2017
bysort AdmitYear: replace annual_total_admissions_T1318 = annual_total_admissions_T1318[1]

*2018
bysort DischargeID: replace annual_total_admissions_T1318 = total_admissions_T1318_2018 if AdmitYear == 2018
bysort annual_total_admissions_T1318: replace annual_total_admissions_T1318 = annual_total_admissions_T1318[1]

*2019*
bysort DischargeID: replace annual_total_admissions_T1318 = total_admissions_T1318_2019 if AdmitYear == 2019
bysort annual_total_admissions_T1318: replace annual_total_admissions_T1318 = annual_total_admissions_T1318[1]

*2020*
bysort DischargeID: replace annual_total_admissions_T1318 = total_admissions_T1318_2020 if AdmitYear == 2020
bysort annual_total_admissions_T1318: replace annual_total_admissions_T1318 = annual_total_admissions_T1318[1]

*2021*
bysort DischargeID: replace annual_total_admissions_T1318 = total_admissions_T1318_2021 if AdmitYear == 2021
bysort annual_total_admissions_T1318: replace annual_total_admissions_T1318 = annual_total_admissions_T1318[1]

*2022*
bysort DischargeID: replace annual_total_admissions_T1318 = total_admissions_T1318_2022 if AdmitYear == 2022
bysort annual_total_admissions_T1318: replace annual_total_admissions_T1318 = annual_total_admissions_T1318[1]

*2023*
bysort DischargeID: replace annual_total_admissions_T1318 = total_admissions_T1318_2023 if AdmitYear == 2023
bysort annual_total_admissions_T1318: replace annual_total_admissions_T1318 = annual_total_admissions_T1318[1]

*2024*
bysort DischargeID: replace annual_total_admissions_T1318 = total_admissions_T1318_2024 if AdmitYear == 2024
bysort annual_total_admissions_T1318: replace annual_total_admissions_T1318 = annual_total_admissions_T1318[1]

tab annual_total_admissions_T1318 AdmitYear





preserve

**GENERATING SINGLE VARIABLE REGRESSION FOR ANNUAL TOTAL ECMO T1318 - ALL PATIENTS**

bysort YearOfService (annual_total_ECMO_T1318): keep if _n==1
browse

drop if annual_total_ECMO_T1318 ==.

tab annual_total_ECMO_T1318 AdmitYear
tab annual_total_admissions_T1318 AdmitYear

plot annual_total_admissions_T1318 AdmitYear

*regression total t13/18 ECMO*
reg annual_total_ECMO_T1318

*regression total t13/18 ECMO by year*
reg annual_total_ECMO_T1318 AdmitYear

*regression total t13/18 admissions*
reg annual_total_admissions_T1318

*regression total t13/18 ECMO by year by total t13/18 admissions*
reg annual_total_ECMO_T1318 YearOfService annual_total_admissions_T1318

restore


order HospitalCity HospitalNumber DischargeID RaceCode Ethnicity Gender AdmitYear YearOfService AdmitAgeInDays admitageyears ECMO_dx_y_n ECMO_y_n ecmo_type1 high_risk_group center_admissions center_admissions_2016 center_admissions_2017 center_admissions_2018 center_admissions_2019 center_admissions_2020 center_admissions_2021 center_admissions_2022 center_admissions_2023 center_admissions_2024 center_totalecmo center_total_ecmo_2016 ecmo_cases_not_high_risk_2016 ecmo_cases_onc_2016 ecmo_cases_trauma_2016 ecmo_cases_trisomy_2016 center_total_ecmo_2017 ecmo_cases_not_high_risk_2017 ecmo_cases_onc_2017 ecmo_cases_trauma_2017 ecmo_cases_trisomy_2017 center_total_ecmo_2018 ecmo_cases_not_high_risk_2018 ecmo_cases_onc_2018 ecmo_cases_trauma_2018 ecmo_cases_trisomy_2018 center_total_ecmo_2019 ecmo_cases_not_high_risk_2019 ecmo_cases_onc_2019 ecmo_cases_trauma_2019 ecmo_cases_trisomy_2019 center_total_ecmo_2020 ecmo_cases_not_high_risk_2020 ecmo_cases_onc_2020 ecmo_cases_trauma_2020 ecmo_cases_trisomy_2020 center_total_ecmo_2021 ecmo_cases_not_high_risk_2021 ecmo_cases_onc_2021 ecmo_cases_trauma_2021 ecmo_cases_trisomy_2021 center_total_ecmo_2022 ecmo_cases_not_high_risk_2022 ecmo_cases_onc_2022 ecmo_cases_trauma_2022 ecmo_cases_trisomy_2022 center_total_ecmo_2023 ecmo_cases_not_high_risk_2023 ecmo_cases_onc_2023 ecmo_cases_trauma_2023 ecmo_cases_trisomy_2023 center_total_ecmo_2024 ecmo_cases_not_high_risk_2024 ecmo_cases_onc_2024 ecmo_cases_trauma_2024 ecmo_cases_trisomy_2024

**REGRESSION**
*creation of empty model*
logistic ECMO_y_n
estimates store modele1 

*creation of level 1 model*
logistic ECMO_y_n ib3.high_risk_group ib0.ECMO_dx_y_n Ethnicity Gender admitageyears AdmitYear 
estimates store model1a

*creation of empty model with fixed effects*
melogit ECMO_y_n||HospitalNumber: , or
estimates store modele2

*creation of multilevel model, fixed effects*
melogit ECMO_y_n ib3.high_risk_group ib0.ECMO_dx_y_n Ethnicity Gender admitageyears AdmitYear center_admissions center_totalecmo number_of_casesonc number_of_casest1318 number_of_casestrauma ||HospitalNumber: , or
estimates store model2a


**MARGINS T1318**
*margins center admissions*
margins, at (center_admissions = (10000(1000)30000) high_risk_group = 0 ECMO_dx_y_n = 1 center_totalecmo = 361.6644 number_of_casesonc = 930.8248 number_of_casest1318 = 98.29036  number_of_casestrauma = 1803.592)

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
melogit ECMO_y_n ib3.high_risk_group ib0.ECMO_dx_y_n Ethnicity Gender admitageyears AdmitYear center_admissions center_totalecmo number_of_casesonc number_of_casest1318 number_of_casestrauma ||HospitalNumber: ib3.high_risk_group , or
estimates store model3
