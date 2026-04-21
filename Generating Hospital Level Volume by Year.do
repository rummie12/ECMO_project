*Generating annual total admissions by center - all-comers*

bysort HospitalNumber: gen center_admissions_by_year = center_admissions_2016 if YearOfService == 1
bysort HospitalNumber: replace center_admissions_by_year = center_admissions_2017 if YearOfService == 2
bysort HospitalNumber: replace center_admissions_by_year = center_admissions_2018 if YearOfService == 3
bysort HospitalNumber: replace center_admissions_by_year = center_admissions_2019 if YearOfService == 4
bysort HospitalNumber: replace center_admissions_by_year = center_admissions_2020 if YearOfService == 5
bysort HospitalNumber: replace center_admissions_by_year = center_admissions_2021 if YearOfService == 6
bysort HospitalNumber: replace center_admissions_by_year = center_admissions_2022 if YearOfService == 7
bysort HospitalNumber: replace center_admissions_by_year = center_admissions_2023 if YearOfService == 8
bysort HospitalNumber: replace center_admissions_by_year = center_admissions_2024 if YearOfService == 9
replace center_admissions_by_year =0 if center_admissions_by_year==.

*Generating annual total ECMO by center - all-comers*

bysort HospitalNumber: gen center_annual_total_ecmo = center_total_ecmo_2016 if YearOfService == 1
bysort HospitalNumber: replace center_annual_total_ecmo = center_total_ecmo_2017 if YearOfService == 2
bysort HospitalNumber: replace center_annual_total_ecmo = center_total_ecmo_2018 if YearOfService == 3
bysort HospitalNumber: replace center_annual_total_ecmo = center_total_ecmo_2019 if YearOfService == 4
bysort HospitalNumber: replace center_annual_total_ecmo = center_total_ecmo_2020 if YearOfService == 5
bysort HospitalNumber: replace center_annual_total_ecmo = center_total_ecmo_2021 if YearOfService == 6
bysort HospitalNumber: replace center_annual_total_ecmo = center_total_ecmo_2022 if YearOfService == 7
bysort HospitalNumber: replace center_annual_total_ecmo = center_total_ecmo_2023 if YearOfService == 8
bysort HospitalNumber: replace center_annual_total_ecmo = center_total_ecmo_2024 if YearOfService == 9
replace center_annual_total_ecmo =0 if center_annual_total_ecmo ==.

*Generating Cluster level ECMO volume by Year*

preserve

mixed c.center_annual_total_ecmo||HospitalNumber:
estat icc

mixed c.center_annual_total_ecmo c.YearOfService||HospitalNumber:
estat icc


mixed c.center_annual_total_ecmo c.YearOfService c.center_admissions_by_year||HospitalNumber:
estat icc

restore












