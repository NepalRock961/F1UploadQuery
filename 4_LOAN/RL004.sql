select * from (
SELECT 
'T' AS tran_type
,'BI' AS tran_sub_type
,F.FORACID AS foracidt
,F.FORACID AS foracid
,'NPR' AS tran_crncy_code
,S.SOL_ID AS sol_id
--,LOAN_AMOUNT
,lpad(round(PRI_OUTSTANDING_AMT,2),17)  AS flow_amt 
,'D' part_tran_type
,'A' AS type_of_dmds
,(select to_char(DB_STAT_DATE,'DD-MM-YYYY') from TBAADM.GCT) AS value_date
,'DISBT' as flow_id
,(select to_char(DB_STAT_DATE,'DD-MM-YYYY') from TBAADM.GCT) AS dmd_date
,'N' AS last_tran_flg
,'N' AS rl004_013
,'N' AS advance_payment_flg
,'' AS prepayment_type
,'' AS int_coll_on_prepayment_flg
,'Migration upload' AS tran_rmks  -- Need to confirm
,'Migration upload' AS tran_particular
FROM MIGRATION.LOAN_DETAILS L
JOIN MIGRATION.FORACID F ON F.ACCOUNT_NUMBER  = L.LOAN_NUMBER
JOIN MIGRATION.SOL_MAPPING S ON L.BANK_DETAILS  = S.OLDBANKID
--where f.foracid in (select foracid from tbaadm.gam where schm_type='LAA')

union  all

SELECT 
'T' AS tran_type
,'BI' AS tran_sub_type
,F.FORACID AS foracidt
,F.sol_id||'02071524001' AS foracid
,'NPR' AS tran_crncy_code
,S.SOL_ID AS sol_id
--,LOAN_AMOUNT
,lpad(round(PRI_OUTSTANDING_AMT,2),17)  AS flow_amt 
,'C' part_tran_type
,'A' AS type_of_dmds
,(select to_char(DB_STAT_DATE,'DD-MM-YYYY') from TBAADM.GCT) AS value_date
,'' as flow_id
,(select to_char(DB_STAT_DATE,'DD-MM-YYYY') from TBAADM.GCT) AS dmd_date
,'N' AS last_tran_flg
,'N' AS rl004_013
,'N' AS advance_payment_flg
,'' AS prepayment_type
,'' AS int_coll_on_prepayment_flg
,'Migration upload' AS tran_rmks  -- Need to confirm
,'Migration upload' AS tran_particular
FROM MIGRATION.LOAN_DETAILS L
JOIN MIGRATION.FORACID F ON F.ACCOUNT_NUMBER  = L.LOAN_NUMBER
JOIN MIGRATION.SOL_MAPPING S ON L.BANK_DETAILS  = S.OLDBANKID
--where f.foracid in (select foracid from tbaadm.gam where schm_type='LAA')
)x
where flow_amt<>0
--and foracid='0300000307870002'
order by SOL_ID, TRAN_CRNCY_CODE,foracidt,part_tran_type asc



--select * from custom.LOAN_DETAILS

--select db_stat_date from tbaadm.gct

