*generating PICU admissions for T1318 by year*
bysort HospitalNumber: egen center_admissions_2016_onc = count(DischargeID) if high_risk_group ==2 & YearOfService ==1 
bysort HospitalNumber: egen center_admissions_2017_onc = count(DischargeID) if high_risk_group ==2 & YearOfService ==2 
bysort HospitalNumber: egen center_admissions_2018_onc = count(DischargeID) if high_risk_group ==2 & YearOfService ==3 
bysort HospitalNumber: egen center_admissions_2019_onc = count(DischargeID) if high_risk_group ==2 & YearOfService ==4 
bysort HospitalNumber: egen center_admissions_2020_onc = count(DischargeID) if high_risk_group ==2 & YearOfService ==5 
bysort HospitalNumber: egen center_admissions_2021_onc = count(DischargeID) if high_risk_group ==2 & YearOfService ==6 
bysort HospitalNumber: egen center_admissions_2022_onc = count(DischargeID) if high_risk_group ==2 & YearOfService ==7 
bysort HospitalNumber: egen center_admissions_2023_onc = count(DischargeID) if high_risk_group ==2 & YearOfService ==8 
bysort HospitalNumber: egen center_admissions_2024_onc = count(DischargeID) if high_risk_group ==2 & YearOfService ==9 

*generating annual PICU admissions for T1318*

bysort HospitalNumber: gen center_admissions_onc = center_admissions_2016_onc if YearOfService ==1
bysort HospitalNumber: replace center_admissions_onc = center_admissions_2017_onc if YearOfService ==2
bysort HospitalNumber: replace center_admissions_onc = center_admissions_2018_onc if YearOfService ==3
bysort HospitalNumber: replace center_admissions_onc = center_admissions_2019_onc if YearOfService ==4
bysort HospitalNumber: replace center_admissions_onc = center_admissions_2020_onc if YearOfService ==5
bysort HospitalNumber: replace center_admissions_onc = center_admissions_2021_onc if YearOfService ==6
bysort HospitalNumber: replace center_admissions_onc = center_admissions_2022_onc if YearOfService ==7
bysort HospitalNumber: replace center_admissions_onc = center_admissions_2023_onc if YearOfService ==8
bysort HospitalNumber: replace center_admissions_onc = center_admissions_2024_onc if YearOfService ==


*generating ECMO for T1318 by Year**
bysort HospitalNumber: egen center_total_ecmo_2016_onc = count(DischargeID) if high_risk_group ==2 & YearOfService ==1 & ECMO_y_n ==1  & ECMO_y_n ==1
bysort HospitalNumber: egen center_total_ecmo_2017_onc = count(DischargeID) if high_risk_group ==2 & YearOfService ==2 & ECMO_y_n ==1  & ECMO_y_n ==1
bysort HospitalNumber: egen center_total_ecmo_2018_onc = count(DischargeID) if high_risk_group ==2 & YearOfService ==3 & ECMO_y_n ==1  & ECMO_y_n ==1
bysort HospitalNumber: egen center_total_ecmo_2019_onc = count(DischargeID) if high_risk_group ==2 & YearOfService ==4 & ECMO_y_n ==1  & ECMO_y_n ==1
bysort HospitalNumber: egen center_total_ecmo_2020_onc = count(DischargeID) if high_risk_group ==2 & YearOfService ==5 & ECMO_y_n ==1  & ECMO_y_n ==1
bysort HospitalNumber: egen center_total_ecmo_2021_onc = count(DischargeID) if high_risk_group ==2 & YearOfService ==6 & ECMO_y_n ==1  & ECMO_y_n ==1
bysort HospitalNumber: egen center_total_ecmo_2022_onc = count(DischargeID) if high_risk_group ==2 & YearOfService ==7 & ECMO_y_n ==1  & ECMO_y_n ==1
bysort HospitalNumber: egen center_total_ecmo_2023_onc = count(DischargeID) if high_risk_group ==2 & YearOfService ==8 & ECMO_y_n ==1  & ECMO_y_n ==1
bysort HospitalNumber: egen center_total_ecmo_2024_onc = count(DischargeID) if high_risk_group ==2 & YearOfService ==9 & ECMO_y_n ==1  & ECMO_y_n ==1

*generating annual ECMO for T1318*
bysort HospitalNumber: gen center_annual_total_ecmo_onc = center_total_ecmo_2016_onc if YearOfService ==1
bysort HospitalNumber: replace center_annual_total_ecmo_onc = center_total_ecmo_2017_onc if YearOfService ==2
bysort HospitalNumber: replace center_annual_total_ecmo_onc = center_total_ecmo_2018_onc if YearOfService ==3
bysort HospitalNumber: replace center_annual_total_ecmo_onc = center_total_ecmo_2019_onc if YearOfService ==4
bysort HospitalNumber: replace center_annual_total_ecmo_onc = center_total_ecmo_2020_onc if YearOfService ==5
bysort HospitalNumber: replace center_annual_total_ecmo_onc = center_total_ecmo_2021_onc if YearOfService ==6
bysort HospitalNumber: replace center_annual_total_ecmo_onc = center_total_ecmo_2022_onc if YearOfService ==7
bysort HospitalNumber: replace center_annual_total_ecmo_onc = center_total_ecmo_2023_onc if YearOfService ==8
bysort HospitalNumber: replace center_annual_total_ecmo_onc = center_total_ecmo_2024_onc if YearOfService ==9
replace center_annual_total_ecmo_onc =0 if center_annual_total_ecmo_onc ==.

*generating cluster regression for onc/bmt*

preserve 

bysort DischargeID: keep if ECMO_y_n==1 & center_annual_total_ecmo_onc !=0
bysort HospitalNumber YearOfService: keep if _n==1 

codebook center_annual_total_ecmo_onc

mixed center_annual_total_ecmo_onc c.center_admissions_onc c.YearOfService||HospitalNumber:

restore


