--drop table custom.int_upl
--select  * from custom.int_upl where BOOKED_UPTO_DATE_DR is null
---------------------MainQuery-----------------------------
create table custom.int_upl as 
select * from (
SELECT 
'INT'    AS    INDICATOR                 
,cast(NULL as varchar(10))    AS    ACID                      
,f.foracid AS    FORACID                   
,'NPR' AS    CRNCY_CODE                
,f.sol_id AS  SOL_ID
,cast(NULL as varchar(10))    AS    INTEREST_CALC_UPTO_DATE_CR
,cast(NULL as varchar(10))   AS    ACCRUED_UPTO_DATE_CR      
,cast(NULL as varchar(10))   AS    BOOKED_UPTO_DATE_CR       
,cast(NULL as varchar(10))    AS    XFER_INT_AMT_CR           
,cast(NULL as varchar(10))   AS    NRML_ACCRUED_AMOUNT_CR    
,cast(NULL as varchar(10))   AS    NRML_BOOKED_AMOUNT_CR     
, to_date(nvl(INTEREST_RUN_UPTO_DATE_DR,(select db_stat_date-1 from tbaadm.gct)),'dd-MON-yyyy')    AS    INTEREST_CALC_UPTO_DATE_DR
,  to_date((select db_stat_date-1 from tbaadm.gct),'dd-MON-yyyy')   AS    ACCRUED_UPTO_DATE_DR      
, to_date(nvl(INTEREST_BOOK_UPTO_DATE_DR,(select db_stat_date-1 from tbaadm.gct)),'dd-MON-yyyy')  AS    BOOKED_UPTO_DATE_DR       
,cast(NULL as varchar(10))   AS    XFER_INT_AMT_DR   
,'0' AS    NRML_ACCRUED_AMOUNT_DR    
,'0' AS    NRML_BOOKED_AMOUNT_DR     
,cast(NULL as varchar(10))   AS    PENALINT_ACCRUED_AMOUNT_DR
,cast(NULL as varchar(10))    AS    PENALINT_BOOKED_AMOUNT_DR 
,cast(NULL as varchar(10))   AS    PENAL_INTEREST_AMOUNT_DR
FROM MIGRATION.LOAN_DETAILS L
JOIN MIGRATION.SOL_MAPPING S ON L.BANK_DETAILS  = S.OLDBANKID
JOIN MIGRATION.FORACID F ON F.ACCOUNT_NUMBER  = L.LOAN_NUMBER
JOIN MIGRATION.FORACID O ON O.ACCOUNT_NUMBER  = L.ACCOUNT_NUMBER
JOIN MIGRATION.SCHEME_MAPPING H ON upper(H.SCHEME_CODE_OLD) = upper(L.SCHM_CODE)  and H.sol_id=f.sol_id
--where o.foracid in (select foracid from tbaadm.gam)
)x -- where foracid is null

--select * from migration.LOAN_DETAILS