SELECT * FROM  (
SELECT --TOP 10
 F.FORACID AS foracid1, 
'T' AS tran_type
,'BI' AS tran_sub_type
,F.FORACID AS foracid
,'NPR' as tran_crncy_code
,S.sol_id AS sol_id
,NVL(PRINCIPAL_AMOUNT,0)-NVL(TOTAL_PAID_PRINCIPAL_AMOUNT,0) as TRAN_AMT
,LPAD(
case when NVL(PRINCIPAL_AMOUNT,0)-NVL(TOTAL_PAID_PRINCIPAL_AMOUNT,0) <1 and NVL(PRINCIPAL_AMOUNT,0)-NVL(TOTAL_PAID_PRINCIPAL_AMOUNT,0)>0 then 
'0'||to_char(NVL(PRINCIPAL_AMOUNT,0)-NVL(TOTAL_PAID_PRINCIPAL_AMOUNT,0))  else to_char(NVL(PRINCIPAL_AMOUNT,0)-NVL(TOTAL_PAID_PRINCIPAL_AMOUNT,0) ) end
,17)  AS flow_amt  
,'D' AS part_tran_type
,'I' AS type_of_dmds
,case when EMI_DATE>(select DB_STAT_DATE from TBAADM.GCT) then (select to_char(DB_STAT_DATE,'dd-mm-yyyy') from TBAADM.GCT)
--when EMI_DATE<(select CASE WHEN acct_opn_date>(SELECT TODAY FROM FINMIG.CONTROLTABLE) 
--THEN (SELECT TODAY FROM FINMIG.CONTROLTABLE)
--ELSE acct_opn_date END from FINMIG.RL001_LOAN rl where rl.foracid=l.foracid) then (SELECT to_char(today,'dd-mm-yyyy') FROM FINMIG.CONTROLTABLE) 
else TO_CHAR(EMI_DATE,'DD-MM-YYYY') end as value_date
,'INDEM' AS flow_id
,case when EMI_DATE>(select DB_STAT_DATE from TBAADM.GCT) then (select to_char(DB_STAT_DATE,'dd-mm-yyyy') from TBAADM.GCT)
--when EMI_DATE<(select CASE WHEN acct_opn_date>(SELECT TODAY FROM FINMIG.CONTROLTABLE) 
--THEN (SELECT TODAY FROM FINMIG.CONTROLTABLE)
--ELSE acct_opn_date END from FINMIG.RL001_LOAN rl where rl.foracid=l.foracid) then (SELECT to_char(today,'dd-mm-yyyy') FROM FINMIG.CONTROLTABLE) 
else TO_CHAR(EMI_DATE,'DD-MM-YYYY') end as dmd_date
 ,'N' AS last_tran_flg
,'N' AS tran_end_indicator
,'N' AS advance_payment_flg
,'' AS prepayment_type
,'' AS int_coll_on_prepayment_flg
,REPLACE(SUBSTR('MIGRATION UPLOAD',1,30),'`','') as tran_rmks
,(SELECT TO_CHAR(DB_STAT_DATE,'DD-MM-YYYY') FROM TBAADM.GCT ) AS tran_particular
FROM MIGRATION.LOAN_CALCULATION L
JOIN MIGRATION.LOAN_DETAILS DS ON L.LOAN_NUMBER  = DS.LOAN_NUMBER
JOIN MIGRATION.FORACID F ON F.ACCOUNT_NUMBER  = L.LOAN_NUMBER
JOIN MIGRATION.SOL_MAPPING S ON DS.BANK_DETAILS  = S.OLDBANKID
WHERE PREDEM_FOR_PRINCIPAL  ='Indem for Interest'
--AND L.PRINCIPAL_AMOUNT<>'0'

UNION ALL


SELECT --TOP 10
 F.FORACID AS foracid1, 
'T' AS tran_type
,'BI' AS tran_sub_type
,S.sol_id||'02072524001'   AS foracid
,'NPR' as tran_crncy_code
,S.sol_id AS sol_id
,NVL(PRINCIPAL_AMOUNT,0)-NVL(TOTAL_PAID_PRINCIPAL_AMOUNT,0) as TRAN_AMT
,LPAD(
case when NVL(PRINCIPAL_AMOUNT,0)-NVL(TOTAL_PAID_PRINCIPAL_AMOUNT,0) <1 and NVL(PRINCIPAL_AMOUNT,0)-NVL(TOTAL_PAID_PRINCIPAL_AMOUNT,0) >0 then 
'0'||to_Char(NVL(PRINCIPAL_AMOUNT,0)-NVL(TOTAL_PAID_PRINCIPAL_AMOUNT,0)) else to_char(NVL(PRINCIPAL_AMOUNT,0)-NVL(TOTAL_PAID_PRINCIPAL_AMOUNT,0)) end 
,17)   AS flow_amt  
,'C' AS part_tran_type
,'I' AS type_of_dmds
,case when EMI_DATE>(select DB_STAT_DATE from TBAADM.GCT) then (select to_char(DB_STAT_DATE,'dd-mm-yyyy') from TBAADM.GCT)
--when EMI_DATE<(select CASE WHEN acct_opn_date>(SELECT TODAY FROM FINMIG.CONTROLTABLE) 
--THEN (SELECT TODAY FROM FINMIG.CONTROLTABLE)
--ELSE acct_opn_date END from FINMIG.RL001_LOAN rl where rl.foracid=l.foracid) then (SELECT to_char(today,'dd-mm-yyyy') FROM FINMIG.CONTROLTABLE) 
else TO_CHAR(EMI_DATE,'DD-MM-YYYY') end as value_date
,'' AS flow_id
,case when EMI_DATE>(select DB_STAT_DATE from TBAADM.GCT) then (select to_char(DB_STAT_DATE,'dd-mm-yyyy') from TBAADM.GCT)
--when EMI_DATE<(select CASE WHEN acct_opn_date>(SELECT TODAY FROM FINMIG.CONTROLTABLE) 
--THEN (SELECT TODAY FROM FINMIG.CONTROLTABLE)
--ELSE acct_opn_date END from FINMIG.RL001_LOAN rl where rl.foracid=l.foracid) then (SELECT to_char(today,'dd-mm-yyyy') FROM FINMIG.CONTROLTABLE) 
else TO_CHAR(EMI_DATE,'DD-MM-YYYY') end as dmd_date
 ,'N' AS last_tran_flg
,'N' AS tran_end_indicator
,'N' AS advance_payment_flg
,'' AS prepayment_type
,'' AS int_coll_on_prepayment_flg
,REPLACE(SUBSTR('MIGRATION UPLOAD',1,30),'`','') as tran_rmks
,(SELECT TO_CHAR(DB_STAT_DATE,'DD-MM-YYYY') FROM TBAADM.GCT ) AS tran_particular
FROM MIGRATION.LOAN_CALCULATION L
JOIN MIGRATION.LOAN_DETAILS DS ON L.LOAN_NUMBER  = DS.LOAN_NUMBER
JOIN MIGRATION.FORACID F ON F.ACCOUNT_NUMBER  = L.LOAN_NUMBER
JOIN MIGRATION.SOL_MAPPING S ON DS.BANK_DETAILS  = S.OLDBANKID
WHERE PREDEM_FOR_PRINCIPAL  ='Indem for Interest'
--AND L.PRINCIPAL_AMOUNT<>'0'

)X
where tran_amt>0
ORDER BY tran_crncy_code,SOL_ID,FORACID1,FLOW_AMT,PART_TRAN_TYPE DESC

--select * from rl005_loan where flow_id='INDEM' and tran_amt>0 and schm_type='LAA'

