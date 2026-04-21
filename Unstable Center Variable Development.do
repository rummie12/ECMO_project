
bysort DischargeID YearOfService(center_admissions_by_year): replace center_admissions_by_year = center_admissions_by_year[1]

bysort HospitalNumber YearOfService(center_admissions_nhr): replace center_admissions_nhr = center_admissions_nhr[1]

bysort HospitalNumber YearOfService(center_admissions_t1318): replace center_admissions_t1318 = center_admissions_t1318[1]

bysort HospitalNumber YearOfService(center_admissions_trauma): replace center_admissions_trauma = center_admissions_trauma[1]

bysort HospitalNumber YearOfService(center_admissions_onc): replace center_admissions_onc = center_admissions_onc[1]


bysort HospitalNumber YearOfService center_annual_total_ecmo: replace center_annual_total_ecmo = center_annual_total_ecmo[_N]

bysort HospitalNumber YearOfService center_annual_total_ecmo_nhr: replace center_annual_total_ecmo_nhr = center_annual_total_ecmo_nhr[_N]

codebook center_annual_total_ecmo_nhr

bysort HospitalNumber YearOfService center_annual_total_ecmo_trauma: replace center_annual_total_ecmo_trauma = center_annual_total_ecmo_trauma[_N]

codebook center_annual_total_ecmo_trauma

bysort HospitalNumber YearOfService center_annual_total_ecmo_t1318: replace center_annual_total_ecmo_t1318 = center_annual_total_ecmo_t1318[_N]

codebook center_annual_total_ecmo_t1318

bysort HospitalNumber YearOfService center_annual_total_ecmo_onc: replace center_annual_total_ecmo_onc = center_annual_total_ecmo_onc[_N]

codebook center_annual_total_ecmo_onc


