**generating PICU admissions for T1318 by year**
bysort HospitalNumber: egen center_admissions_2016_trauma = count(DischargeID) if high_risk_group ==1 & YearOfService ==1 
bysort HospitalNumber: egen center_admissions_2017_trauma = count(DischargeID) if high_risk_group ==1 & YearOfService ==2 
bysort HospitalNumber: egen center_admissions_2018_trauma = count(DischargeID) if high_risk_group ==1 & YearOfService ==3 
bysort HospitalNumber: egen center_admissions_2019_trauma = count(DischargeID) if high_risk_group ==1 & YearOfService ==4 
bysort HospitalNumber: egen center_admissions_2020_trauma = count(DischargeID) if high_risk_group ==1 & YearOfService ==5 
bysort HospitalNumber: egen center_admissions_2021_trauma = count(DischargeID) if high_risk_group ==1 & YearOfService ==6 
bysort HospitalNumber: egen center_admissions_2022_trauma = count(DischargeID) if high_risk_group ==1 & YearOfService ==7 
bysort HospitalNumber: egen center_admissions_2023_trauma = count(DischargeID) if high_risk_group ==1 & YearOfService ==8 
bysort HospitalNumber: egen center_admissions_2024_trauma = count(DischargeID) if high_risk_group ==1 & YearOfService ==9 

**generating annual PICU admissions for T1318**

bysort HospitalNumber: gen center_admissions_trauma = center_admissions_2016_trauma if YearOfService ==1
bysort HospitalNumber: replace center_admissions_trauma = center_admissions_2017_trauma if YearOfService ==2
bysort HospitalNumber: replace center_admissions_trauma = center_admissions_2018_trauma if YearOfService ==3
bysort HospitalNumber: replace center_admissions_trauma = center_admissions_2019_trauma if YearOfService ==4
bysort HospitalNumber: replace center_admissions_trauma = center_admissions_2020_trauma if YearOfService ==5
bysort HospitalNumber: replace center_admissions_trauma = center_admissions_2021_trauma if YearOfService ==6
bysort HospitalNumber: replace center_admissions_trauma = center_admissions_2022_trauma if YearOfService ==7
bysort HospitalNumber: replace center_admissions_trauma = center_admissions_2023_trauma if YearOfService ==8
bysort HospitalNumber: replace center_admissions_trauma = center_admissions_2024_trauma if YearOfService ==9

codebook center_admissions_trauma


*generating ECMO for T1318 by Year*
bysort HospitalNumber: egen center_total_ecmo_2016_trauma = count(DischargeID) if high_risk_group ==1 & YearOfService ==1 & ECMO_y_n ==1  & ECMO_y_n ==1
bysort HospitalNumber: egen center_total_ecmo_2017_trauma = count(DischargeID) if high_risk_group ==1 & YearOfService ==2 & ECMO_y_n ==1  & ECMO_y_n ==1
bysort HospitalNumber: egen center_total_ecmo_2018_trauma = count(DischargeID) if high_risk_group ==1 & YearOfService ==3 & ECMO_y_n ==1  & ECMO_y_n ==1
bysort HospitalNumber: egen center_total_ecmo_2019_trauma = count(DischargeID) if high_risk_group ==1 & YearOfService ==4 & ECMO_y_n ==1  & ECMO_y_n ==1
bysort HospitalNumber: egen center_total_ecmo_2020_trauma = count(DischargeID) if high_risk_group ==1 & YearOfService ==5 & ECMO_y_n ==1  & ECMO_y_n ==1
bysort HospitalNumber: egen center_total_ecmo_2021_trauma = count(DischargeID) if high_risk_group ==1 & YearOfService ==6 & ECMO_y_n ==1  & ECMO_y_n ==1
bysort HospitalNumber: egen center_total_ecmo_2022_trauma = count(DischargeID) if high_risk_group ==1 & YearOfService ==7 & ECMO_y_n ==1  & ECMO_y_n ==1
bysort HospitalNumber: egen center_total_ecmo_2023_trauma = count(DischargeID) if high_risk_group ==1 & YearOfService ==8 & ECMO_y_n ==1  & ECMO_y_n ==1
bysort HospitalNumber: egen center_total_ecmo_2024_trauma = count(DischargeID) if high_risk_group ==1 & YearOfService ==9 & ECMO_y_n ==1  & ECMO_y_n ==1


*generating annual ECMO for T1318*
bysort HospitalNumber: gen center_annual_total_ecmo_trauma = center_total_ecmo_2016_trauma if YearOfService ==1
bysort HospitalNumber: replace center_annual_total_ecmo_trauma = center_total_ecmo_2017_trauma if YearOfService ==2
bysort HospitalNumber: replace center_annual_total_ecmo_trauma = center_total_ecmo_2018_trauma if YearOfService ==3
bysort HospitalNumber: replace center_annual_total_ecmo_trauma = center_total_ecmo_2019_trauma if YearOfService ==4
bysort HospitalNumber: replace center_annual_total_ecmo_trauma = center_total_ecmo_2020_trauma if YearOfService ==5
bysort HospitalNumber: replace center_annual_total_ecmo_trauma = center_total_ecmo_2021_trauma if YearOfService ==6
bysort HospitalNumber: replace center_annual_total_ecmo_trauma = center_total_ecmo_2022_trauma if YearOfService ==7
bysort HospitalNumber: replace center_annual_total_ecmo_trauma = center_total_ecmo_2023_trauma if YearOfService ==8
bysort HospitalNumber: replace center_annual_total_ecmo_trauma = center_total_ecmo_2024_trauma if YearOfService ==9
replace center_annual_total_ecmo_trauma =0 if center_annual_total_ecmo_trauma ==.


*generating cluster level regression t1318*
preserve

bysort DischargeID: keep if ECMO_y_n==1 & center_annual_total_ecmo_trauma !=0
bysort HospitalNumber YearOfService: keep if _n==1 
mixed center_annual_total_ecmo_trauma c.center_admissions_trauma c.YearOfService||HospitalNumber:

restore


