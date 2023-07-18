--select * from CUSTOM.C_BOOK_PENAL

--select * from custom.penal

--select * from custom.LOAN_CALCULATION
--select TBAADM.C_SVRSETVAR, from TBAADM.C_SVRSETVAR
--where module_name='031' 

--delete from custom.C_BOOK_PENAL where tran_id is null

--create table custom.C_BOOK_PENAL1 as select * from custom.C_BOOK_PENAL where tran_id is null



insert into custom.C_BOOK_PENAL   
SELECT 
CIF_ID          ,
ACID           ,
DMD_DATE       ,
BOOK_DATE      ,
3 PP_RATE        ,
PRDEM_DUE      ,
POVDDAILY      ,
CALC_POVDDAILY ,
2 PI_RATE        ,
INDEM_DUE      ,
IOVDDAILY      ,
CALC_IOVDDAILY ,
TRAN_DATE      ,
TRAN_ID        ,
GRACEPERIOD    ,
DUE_FLG        ,
EFFECTIVE_DATE ,
DEL_FLG        ,
RCRE_USER_ID   ,
RCRE_TIME      ,
LCHG_USER_ID   ,
LCHG_TIME      
from (
select x.*, round((PRDEM_DUE*3*DIFF/36500),2) POVDDAILY, round((PRDEM_DUE*3*DIFF/36500),4) CALC_POVDDAILY, 
round((INDEM_DUE*2*DIFF/36500),2) IOVDDAILY,round((INDEM_DUE*2*DIFF/36500),2) CALC_IOVDDAILY from (
select
g.cif_Id as   CIF_ID          ,
acid as   ACID           ,
EMI_DATE as   DMD_DATE       ,
EMI_DATE as   BOOK_DATE      ,
(select distinct nvl(VARIABLE_VALUE,3) from TBAADM.C_SVRSETVAR x where x.module_name=g.sol_id and type=schm_Code and variable_name='PP_RATE') as   PP_RATE        ,
round((select to_date(sysdate,'dd-mm-yyyy') from dual)-to_date(EMI_DATE,'dd-mm-yyyy'),2) as diff,
nvl(sum(PRDEM),0) as   PRDEM_DUE      ,
'' as   POVDDAILY1      ,
'' as   CALC_POVDDAILY1 ,
(select distinct nvl(VARIABLE_VALUE,2) from TBAADM.C_SVRSETVAR x where x.module_name=g.sol_id and type=schm_Code and variable_name='PI_RATE') as   PI_RATE        ,
nvl(sum(INDEM_INT),0) as   INDEM_DUE      ,
'' as   IOVDDAILY1      ,
'' as   CALC_IOVDDAILY1 ,
'' as   TRAN_DATE      ,
'' as   TRAN_ID        ,
'0' as   GRACEPERIOD    ,
'Y' as   DUE_FLG        ,
'' as   EFFECTIVE_DATE ,
'N' as   DEL_FLG        ,
'2299' as   RCRE_USER_ID   ,
(select db_stat_date from tbaadm.gct) as   RCRE_TIME      ,
'2299' as   LCHG_USER_ID   ,
(select db_stat_date from tbaadm.gct) as   LCHG_TIME      
from  migration.penal c
 join migration.foracid f on c.loan_number=f.account_number
 join tbaadm.gam g on g.foracid=f.foracid
 where PRDEM<>0 or INDEM_INT<>0
 group by g.cif_Id,acid,EMI_DATE,g.sol_id,schm_Code
)x
)y