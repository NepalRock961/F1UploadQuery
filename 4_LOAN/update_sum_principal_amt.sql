select * from (
select * from (
select foracid,sum(dmd_amt) PRINCIPAL_AMOUNT from (
SELECT 
'I' as indi,
f.foracid AS foracid
,to_char(emi_date,'dd-mm-yyyy') AS dmd_date
,to_char(emi_date,'dd-mm-yyyy')   AS dmd_eff_date
,case when PREDEM_FOR_PRINCIPAL = 'Predem for Principal' then 'PRDEM'
 when PREDEM_FOR_PRINCIPAL = 'Indem for Interest' then 'INDEM'  end as   dmd_flow_id
,LPAD(nvl(PRINCIPAL_AMOUNT,0),17)  AS dmd_amt
,'N' AS late_fee_applied
,'' AS late_fee_amount
,''  AS late_fee_date
,''  AS latefee_status_flg
,''  AS late_fee_currency_code
,''  AS dmd_ovdu_date
,'' AS accrued_penal_interest_amount
,''  AS iban_number
,'' AS ACID
FROM CUSTOM.LOAN_CALCULATION L
JOIN CUSTOM.LOAN_DETAILS DS ON L.LOAN_NUMBER  = DS.LOAN_NUMBER
JOIN CUSTOM.FORACID F ON F.ACCOUNT_NUMBER  = L.LOAN_NUMBER
WHERE PREDEM_FOR_PRINCIPAL IN ('Predem for Principal')
AND PRINCIPAL_AMOUNT>0
and foracid in (select foracid from tbaadm.gam)
)s

group by foracid
)x join tbaadm.gam g on x.foracid=g.foracid
)y

--select SUM_PRINCIPAL_DMD_AMT from tbaadm.lam l 

update tbaadm.lam l
set sum_principal_dmd_amt=(
select dmd_amt from (select sum(dmd_amt) dmd_amt,acid from  (SELECT 
acid,
f.foracid AS foracid
,LPAD(nvl(PRINCIPAL_AMOUNT,0),17)  AS dmd_amt
FROM CUSTOM.LOAN_CALCULATION L
JOIN CUSTOM.LOAN_DETAILS DS ON L.LOAN_NUMBER  = DS.LOAN_NUMBER
JOIN CUSTOM.FORACID F ON F.ACCOUNT_NUMBER  = L.LOAN_NUMBER
join tbaadm.gam g on g.foracid=f.foracid
WHERE PREDEM_FOR_PRINCIPAL IN ('Predem for Principal')
AND PRINCIPAL_AMOUNT>0
and f.foracid in (select foracid from tbaadm.gam)
)y group by foracid,acid
)x where l.acid=x.acid
)


commit
