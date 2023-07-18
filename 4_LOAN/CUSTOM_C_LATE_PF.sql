--select * from  custom.c_late_pf
--create table custom.c_late_pf1 as select * from custom.c_late_pf
insert into custom.c_late_pf  
select * from (
SELECT   
sum(PRDEM)  PRIN_DUE                   ,
sum(INDEM_LATE)  INT_DUE                  ,
EMI_DATE  DMD_DATE                 ,
EMI_DATE LATEPAY_APPLICABLE_DATE  ,
acid  ACID                     ,
f.foracid  LOAN_ACC                 ,
(select sa.foracid from tbaadm.gam sa where sa.acid=(select op_acid from tbaadm.lam la where la.acid=g.acid )) OP_ACC                   ,
sum(nvl(INDEM_LATE,0)) FEE_AMT                  ,
(select db_stat_date from tbaadm.gct)  RCRE_TIME                ,
(select db_stat_date from tbaadm.gct)  LCHG_TIME                ,
'SYSTEM'  RCRE_USER_ID             ,
'SYSTEM'  LCHG_USER_ID             ,
'0'  REMARKS                  ,
'Y'  APPLICABLE_FLG           ,
'N'  COLL_FLG                 ,
''  COLL_DATE                ,
'0'  COLL_AMT                 ,
g.sol_Id  SOL_ID                  ,
'' REVERSAL_FLG  
 from MIGRATION.penal c
 join MIGRATION.foracid f on c.loan_number=f.account_number
 join tbaadm.gam g on g.foracid=f.foracid
 --where f.account_number='1011000048510957'
group by EMI_DATE,f.foracid,acid,g.sol_Id
)x
where prin_due<>0 or int_due<>0


