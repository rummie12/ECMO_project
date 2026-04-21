**generating PICU admissions for Not-High Risk by Year**
bysort HospitalNumber: egen center_admissions_2016_nhr = count(DischargeID) if high_risk_group ==3 & YearOfService ==1 
bysort HospitalNumber: egen center_admissions_2017_nhr = count(DischargeID) if high_risk_group ==3 & YearOfService ==2 
bysort HospitalNumber: egen center_admissions_2018_nhr = count(DischargeID) if high_risk_group ==3 & YearOfService ==3 
bysort HospitalNumber: egen center_admissions_2019_nhr = count(DischargeID) if high_risk_group ==3 & YearOfService ==4 
bysort HospitalNumber: egen center_admissions_2020_nhr = count(DischargeID) if high_risk_group ==3 & YearOfService ==5 
bysort HospitalNumber: egen center_admissions_2021_nhr = count(DischargeID) if high_risk_group ==3 & YearOfService ==6 
bysort HospitalNumber: egen center_admissions_2022_nhr = count(DischargeID) if high_risk_group ==3 & YearOfService ==7 
bysort HospitalNumber: egen center_admissions_2023_nhr = count(DischargeID) if high_risk_group ==3 & YearOfService ==8 
bysort HospitalNumber: egen center_admissions_2024_nhr = count(DischargeID) if high_risk_group ==3 & YearOfService ==9 

**generating PICU annual admissions for Not-High Risk**

bysort HospitalNumber: gen center_admissions_nhr = center_admissions_2016_nhr if YearOfService ==1
bysort HospitalNumber: replace center_admissions_nhr = center_admissions_2017_nhr if YearOfService ==2
bysort HospitalNumber: replace center_admissions_nhr = center_admissions_2018_nhr if YearOfService ==3
bysort HospitalNumber: replace center_admissions_nhr = center_admissions_2019_nhr if YearOfService ==4
bysort HospitalNumber: replace center_admissions_nhr = center_admissions_2020_nhr if YearOfService ==5
bysort HospitalNumber: replace center_admissions_nhr = center_admissions_2021_nhr if YearOfService ==6
bysort HospitalNumber: replace center_admissions_nhr = center_admissions_2022_nhr if YearOfService ==7
bysort HospitalNumber: replace center_admissions_nhr = center_admissions_2023_nhr if YearOfService ==8
bysort HospitalNumber: replace center_admissions_nhr = center_admissions_2024_nhr if YearOfService ==9

codebook center_admissions_nhr


**generating ECMO for Not-high risk by Year**
bysort HospitalNumber: egen center_total_ecmo_2016_nhr = count(DischargeID) if high_risk_group ==3 & YearOfService ==1 & ECMO_y_n ==1  & ECMO_y_n ==1
bysort HospitalNumber: egen center_total_ecmo_2017_nhr = count(DischargeID) if high_risk_group ==3 & YearOfService ==2 & ECMO_y_n ==1  & ECMO_y_n ==1
bysort HospitalNumber: egen center_total_ecmo_2018_nhr = count(DischargeID) if high_risk_group ==3 & YearOfService ==3 & ECMO_y_n ==1  & ECMO_y_n ==1
bysort HospitalNumber: egen center_total_ecmo_2019_nhr = count(DischargeID) if high_risk_group ==3 & YearOfService ==4 & ECMO_y_n ==1  & ECMO_y_n ==1
bysort HospitalNumber: egen center_total_ecmo_2020_nhr = count(DischargeID) if high_risk_group ==3 & YearOfService ==5 & ECMO_y_n ==1  & ECMO_y_n ==1
bysort HospitalNumber: egen center_total_ecmo_2021_nhr = count(DischargeID) if high_risk_group ==3 & YearOfService ==6 & ECMO_y_n ==1  & ECMO_y_n ==1
bysort HospitalNumber: egen center_total_ecmo_2022_nhr = count(DischargeID) if high_risk_group ==3 & YearOfService ==7 & ECMO_y_n ==1  & ECMO_y_n ==1
bysort HospitalNumber YearOfService: egen center_total_ecmo_2023_nhr = count(DischargeID) if high_risk_group ==3 & YearOfService ==8 & ECMO_y_n ==1  & ECMO_y_n ==1
bysort HospitalNumber: egen center_total_ecmo_2024_nhr = count(DischargeID) if high_risk_group ==3 & YearOfService ==9 & ECMO_y_n ==1  & ECMO_y_n ==1

**generating annual ECMO for Not-high risk**

bysort HospitalNumber: gen center_annual_total_ecmo_nhr = center_total_ecmo_2016_nhr if YearOfService ==1
bysort HospitalNumber: replace center_annual_total_ecmo_nhr = center_total_ecmo_2017_nhr if YearOfService ==2
bysort HospitalNumber: replace center_annual_total_ecmo_nhr = center_total_ecmo_2018_nhr if YearOfService ==3
bysort HospitalNumber: replace center_annual_total_ecmo_nhr = center_total_ecmo_2019_nhr if YearOfService ==4
bysort HospitalNumber: replace center_annual_total_ecmo_nhr = center_total_ecmo_2020_nhr if YearOfService ==5
bysort HospitalNumber: replace center_annual_total_ecmo_nhr = center_total_ecmo_2021_nhr if YearOfService ==6
bysort HospitalNumber: replace center_annual_total_ecmo_nhr = center_total_ecmo_2022_nhr if YearOfService ==7
bysort HospitalNumber: replace center_annual_total_ecmo_nhr = center_total_ecmo_2023_nhr if YearOfService ==8
bysort HospitalNumber: replace center_annual_total_ecmo_nhr = center_total_ecmo_2024_nhr if YearOfService ==9
replace center_annual_total_ecmo_nhr =0 if center_annual_total_ecmo_nhr ==.

**Generating Cluster Regression**

preserve

bysort DischargeID: keep if ECMO_y_n==1 & center_annual_total_ecmo_nhr !=0
bysort HospitalNumber YearOfService: keep if _n==1 

tab HospitalNumber YearOfService if ECMO_y_n ==1

mixed center_annual_total_ecmo_nhr c.center_admissions_nhr c.YearOfService||HospitalNumber:

restore


