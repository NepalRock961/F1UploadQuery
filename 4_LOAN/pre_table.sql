--drop table custom.penal

--select * from custom.penal

create table  MIGRATION.penal as 
select * from (
select 
loan_number,
loan_id,
EMI_DATE,
sum(PRINCIPAL_AMOUNT-TOTAL_PAID_PRINCIPAL_AMOUNT) PRDEM,
0 INDEM_INT,
0 INDEM_late,
0 penalty
 from MIGRATION.LOAN_CALCULATION
 where PREDEM_FOR_PRINCIPAL='Predem for Principal'
 and PRINCIPAL_AMOUNT-TOTAL_PAID_PRINCIPAL_AMOUNT<>0
 group by EMI_DATE,loan_number,EMI_DATE,loan_id
 
 union all
 
 select 
loan_number,
loan_id,
EMI_DATE,
0 PRDEM,
sum(PRINCIPAL_AMOUNT-TOTAL_PAID_PRINCIPAL_AMOUNT) INDEM_INT,
0 INDEM_late,
0 penalty
 from MIGRATION.LOAN_CALCULATION
 where PREDEM_FOR_PRINCIPAL='Indem for Interest'
 and PRINCIPAL_AMOUNT-TOTAL_PAID_PRINCIPAL_AMOUNT<>0
 group by EMI_DATE,loan_number,EMI_DATE,loan_id
 
 union all
 
 select 
loan_number,
loan_id,
EMI_DATE,
0 PRDEM,
0 INDEM_INT,
sum(PRINCIPAL_AMOUNT-TOTAL_PAID_PRINCIPAL_AMOUNT) INDEM_late,
0 penalty
 from MIGRATION.LOAN_CALCULATION
 where PREDEM_FOR_PRINCIPAL='Indem for late fee'
 and PRINCIPAL_AMOUNT-TOTAL_PAID_PRINCIPAL_AMOUNT<>0
 group by EMI_DATE,loan_number,EMI_DATE,loan_id
 
 union all
 
 select 
loan_number,
loan_id,
EMI_DATE,
0 PRDEM,
0 INDEM_INT,
0 INDEM_late,
sum(PRINCIPAL_AMOUNT-TOTAL_PAID_PRINCIPAL_AMOUNT) penalty
 from MIGRATION.LOAN_CALCULATION
 where PREDEM_FOR_PRINCIPAL='Penalty'
 and PRINCIPAL_AMOUNT-TOTAL_PAID_PRINCIPAL_AMOUNT<>0
 group by EMI_DATE,loan_number,EMI_DATE,loan_id
 )x
 --where loan_number='1011003162800915'