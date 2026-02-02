clear

**using all patient data**
use "C:\Users\laxfr\Desktop\All-Comers\All Patients\Stata\Data\All Patients Modified Table 1.dta"
rename DxCodeICD ECMODxICD
gen ECMO_dx_y_n =1



**merging onc population**

merge m:m DischargeID using "C:\Users\laxfr\Desktop\All-Comers\Onc-BMT\Stata\Data\All Admitted Onc-BMT Modified Table 1 Data.dta"


rename _merge _merge_onc

**merging trauma population**
merge m:m DischargeID using "C:\Users\laxfr\Desktop\All-Comers\Trauma\Stata\Data\All Trauma Patients Modified Table 1.dta"


rename _merge _merge_trauma

**merging trisomy population**
merge m:m DischargeID using "C:\Users\laxfr\Desktop\All-Comers\Trisomy\Stata\Data\All Trisomy Patients Modified Table 1.dta"


rename _merge _merge_trisomy

format DischargeID %15.4f

browse


**merging ECMO Patient Level Data**
merge m:m DischargeID using "C:\Users\laxfr\Desktop\Fellowship Files\CHEAR Fellowship\Research\ECMO Practica 1\Data\All Hospital\Stata\Data\All ECMO Cases pulled by Px and Date.dta"

rename _merge _merge_Patient_ECMO_data

**merging HospitalLevel Data**
merge m:m HospitalNumber using "C:\Users\laxfr\Desktop\Fellowship Files\CHEAR Fellowship\Research\ECMO Practica 1\Data\All Hospital\All Hospital Case Mixes.dta"

**cleaning data + definitions**

drop if center_total_ecmo ==.

**drop high risk group**
drop high_risk_group

**remaking high_risk_group**

gen high_risk_group=.
replace high_risk_group = 0 if trisomy_pop ==1
replace high_risk_group = 1 if trauma_pop ==1
replace high_risk_group = 2 if onc_pop ==1
replace high_risk_group = 3 if high_risk_group ==.

**replacing ecmo_type1 = 7 if no receipt**
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

**replacing high risk diagnosis**
replace high_risk_group =3 if high_risk_group ==.

**relabeling high_risk_group**
label define high_risk_group 0 "Trisomy 13/18" 1 "Trauma" 2 "Onc/BMT" 3 "Not High-Risk"
label values high_risk_group high_risk_group

**Replacing ECMO_dx_y_n**
replace ECMO_dx_y_n = 0 if ECMO_dx_y_n ==.

**relabeling ECMO_dx_y_n**
label define ECMO_dx_y_n 0 "No ECMO Dx" 1 "ECMO Dx"
label values ECMO_dx_y_n ECMO_dx_y_n

**gen High Risk Y_N**
gen high_risk_group_y_n =.
replace high_risk_group_y_n = 1 if high_risk_group <3
replace high_risk_group_y_n = 0 if high_risk_group ==3


**label high_risk_group_y_n**
label define high_risk_group_y_n 0 "Not High Risk" 1 "High Risk"
label values high_risk_group_y_n high_risk_group_y_n

**Replacing onc_pop if missing**
replace onc_pop = 0 if onc_pop ==.

**label onc_pop**
label define onc_pop 0 "Not Onc/BMT" 1 "Onc/BMT"
label values onc_pop onc_pop

**Replacing trauma_pop if missing**
replace trauma_pop = 0 if trauma_pop ==.

*label trauma_pop**
label define trauma_pop 0 "Not Trauma" 1 "Trauma"
label values trauma_pop trauma_pop

**Replacing trisomy_pop if missing**
replace trisomy_pop =0 if trisomy_pop ==.

**label trisomy_pop**
label define trisomy_pop 0 "Not Trisomy" 1 "Trisomy"
label values trisomy_pop trisomy_pop

bysort DischargeID: gen first= _n==1

summarize number_of_cases_trauma
gen predict_number_of_cases_trauma =.
replace predict_number_of_cases_trauma = 572.3265
replace number_of_cases_trauma = predict_number_of_cases_trauma if number_of_cases_trauma ==.
summarize number_of_cases_trisomy
gen predict_number_of_cases_trisomy =.
replace predict_number_of_cases_trisomy = 38.55556
replace number_of_cases_trisomy = predict_number_of_cases_trisomy if number_of_cases_trisomy ==.
summarize number_of_cases_onc
gen predict_number_of_cases_onc =.
replace predict_number_of_cases_onc = 112.3684 
replace number_of_cases_onc = predict_number_of_cases_onc if number_of_cases_onc==.

melogit ECMO_y_n ib0.ECMO_dx_y_n ib3.high_risk_group Ethnicity Gender AdmitAgeInYears AdmitYear center_TotalAdmissions center_total_ecmo number_of_cases_onc number_of_cases_trauma number_of_cases_trisomy ||HospitalNumber:








