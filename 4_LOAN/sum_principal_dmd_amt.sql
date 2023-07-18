--drop table custom.OVERDUE_DETAIL

CREATE TABLE MIGRATION.OVERDUE_DETAIL AS (
select loan_number,PREDEM_FOR_PRINCIPAL,sum(PRINCIPAL_AMOUNT-TOTAL_PAID_PRINCIPAL_AMOUNT) as principal_overdues
from MIGRATION.LOAN_CALCULATION
group by loan_number,PREDEM_FOR_PRINCIPAL
)

--select * from MIGRATION.LOAN_DETAILS

create index loan_detalils on migration.LOAN_CALCULATION(loan_number)

create index OVERDUE_DETAIL on migration.OVERDUE_DETAIL(loan_number)


select * from MIGRATION.LOAN_DETAILS

create table migration.loan_details1 as select * from migration.loan_details

create table migration.loan_details as
select 
  LOAN_ID                      ,
  LOAN_NUMBER                  ,
  CIF_ID                       ,
  ACCOUNT_NUMBER               ,
  ACCT_CURRENCY_CODE           ,
  BRANCH_ID                    ,
  BRANCH_NAME                  ,
  BANK_DETAILS                 ,
  BANK_NAME                    ,
  SCHM_CODE                    ,
  LOAN_AMOUNT as INTEREST_RATE ,           
  INTEREST_RATE as LOAN_AMOUNT ,             
  ACCT_OPEN_DATE               ,
  LIMIT_APPLICABLE_DATE        ,
  LIMIT_EXP_DATE               ,
  EMI_FREQUENCY                ,
  PAST_DUE_FLAGE               ,
  PAST_DUE_DATE                ,
  PRI_OUTSTANDING_AMT          ,
  INTEREST_BOOK_UPTO_DATE_DR   ,
  INTEREST_RUN_UPTO_DATE_DR    ,
  PRI_OVERDUE_AMT              ,
  INT_OVERDUE_AMT              ,
  PENAL_AMOUNT                 ,
  LATE_PAY_FEE                 ,
  TENURE_IN_MONTH              
from migration.loan_details1