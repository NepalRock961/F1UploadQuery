--drop table  migration.eit

create table migration.eit
as 
    select E.FORACID,GAM.ACID, E.CRNCY_CODE,E.SOL_ID,INTEREST_CALC_UPTO_DATE_CR,ACCRUED_UPTO_DATE_CR,BOOKED_UPTO_DATE_CR,
XFER_INT_AMT_CR,NRML_ACCRUED_AMOUNT_CR,NRML_BOOKED_AMOUNT_CR,
to_date(NVL(INTEREST_CALC_UPTO_DATE_DR,(select db_stat_date-1 from tbaadm.gct)),'DD-MON-yyyy') INTEREST_CALC_UPTO_DATE_DR,
to_date(ACCRUED_UPTO_DATE_DR,'DD-MON-yyyy') ACCRUED_UPTO_DATE_DR,
to_date(BOOKED_UPTO_DATE_DR,'DD-MON-yyyy') BOOKED_UPTO_DATE_DR,
XFER_INT_AMT_DR,NRML_ACCRUED_AMOUNT_DR,NRML_BOOKED_AMOUNT_DR,
'0' LAST_NRML_BOOKED_AMOUNT_DR,PENALINT_ACCRUED_AMOUNT_DR,PENALINT_BOOKED_AMOUNT_DR,PENAL_INTEREST_AMOUNT_DR  from custom.int_upl E,
TBAADM.GAM WHERE GAM.FORACID = E.FORACID ;

MERGE into tbaadm.eit e
USING migration.eit i
ON (e.entity_id = i.acid)
WHEN MATCHED THEN UPDATE SET e.INTEREST_CALC_UPTO_DATE_DR = to_date(i.INTEREST_CALC_UPTO_DATE_DR,'dd-MON-YYYY'),
    e.ACCRUED_UPTO_DATE_DR = to_char(i.ACCRUED_UPTO_DATE_DR,'dd-MON-yyyy'),
    e.BOOKED_UPTO_DATE_DR = to_char(i.BOOKED_UPTO_DATE_DR,'dd-MON-yyyy'),
    e.NRML_ACCRUED_AMOUNT_DR = i.NRML_ACCRUED_AMOUNT_DR,
    e.NRML_BOOKED_AMOUNT_DR = i.NRML_BOOKED_AMOUNT_DR,
    e.LAST_NRML_BOOKED_AMOUNT_DR = i.LAST_NRML_BOOKED_AMOUNT_DR
    
    
 