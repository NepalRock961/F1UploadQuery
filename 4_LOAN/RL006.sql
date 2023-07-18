SELECT 
'I' as indi,
f.foracid AS foracid
,to_char(emi_date,'dd-mm-yyyy') AS dmd_date
,to_char(emi_date,'dd-mm-yyyy')   AS dmd_eff_date
,case when PREDEM_FOR_PRINCIPAL = 'Predem for Principal' then 'PRDEM'
 when PREDEM_FOR_PRINCIPAL = 'Indem for Interest' then 'INDEM'  end as   dmd_flow_id
,LPAD(

case when NVL(PRINCIPAL_AMOUNT,0)-NVL(TOTAL_PAID_PRINCIPAL_AMOUNT,0)>0 and  NVL(PRINCIPAL_AMOUNT,0)-NVL(TOTAL_PAID_PRINCIPAL_AMOUNT,0)<1 then 
'0'||to_char( NVL(PRINCIPAL_AMOUNT,0)-NVL(TOTAL_PAID_PRINCIPAL_AMOUNT,0)) else  to_char(NVL(PRINCIPAL_AMOUNT,0)-NVL(TOTAL_PAID_PRINCIPAL_AMOUNT,0)) end 

,17)  AS dmd_amt
,'N' AS late_fee_applied
,'' AS late_fee_amount
,''  AS late_fee_date
,''  AS latefee_status_flg
,''  AS late_fee_currency_code
,''  AS dmd_ovdu_date
,'' AS accrued_penal_interest_amount
,''  AS iban_number
,'' AS ACID
FROM MIGRATION.LOAN_CALCULATION L
JOIN MIGRATION.LOAN_DETAILS DS ON L.LOAN_NUMBER  = DS.LOAN_NUMBER
JOIN MIGRATION.FORACID F ON F.ACCOUNT_NUMBER  = L.LOAN_NUMBER
WHERE PREDEM_FOR_PRINCIPAL IN ('Predem for Principal','Indem for Interest')
AND NVL(PRINCIPAL_AMOUNT,0)-NVL(TOTAL_PAID_PRINCIPAL_AMOUNT,0)>0
--and L.loan_number='2022004832303772'
--and foracid in (select foracid from tbaadm.gam)
ORDER BY 2,3,5 DESC
