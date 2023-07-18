

select cif_Id from migration.cif_id
group by cif_id
having count(*)>1

select customer_id from migration.cif_id
group by customer_id
having count(*)>1

--drop table custom.foracid

create index test_01 on migration.foracid(foracid,cif_id)

create index test_02 on migration.foracid(account_number)

create index test_03 on migration.loan_details(account_number)


select count(*)  
FROM migration.LOAN_DETAILS L where bank_details not in (select oldbankid from migration.SOL_MAPPING) --317 not available

--drop table MIGRATION.foracid


CREATE TABLE MIGRATION.foracid
AS
   (SELECT x.*,
           sol_id || SUBSTR (cif_id, 2, 10) || LPAD (ROW_NUMBER ()OVER (PARTITION BY customer_id ORDER BY customer_id, schm_type DESC),4, '0') foracid
      FROM (
    select * from (  SELECT distinct TO_CHAR (cd.customer_id) customer_id,
                   cif_id AS cif_id,
                   ACCOUNT_NUMBER,
                   'SBA' schm_type,
                   TO_CHAR (BANK_ID) branch_Code,
                   nvl( TO_CHAR (s.SOL_ID),'030') sol_id,
                   TO_CHAR ( (SELECT db_stat_date - 1 FROM tbaadm.gct),'dd-mm-yyyy') ACCT_OPEN_DATE
                 
              FROM   MIGRATION.customer_details cd
                  left JOIN MIGRATION.sol_mapping s ON s.oldbankid = cd.bank_id
                   join MIGRATION.CIF_ID c on c.customer_ID=cd.customer_id
                   )x where ACCOUNT_NUMBER is not null
            UNION ALL
            SELECT TO_CHAR (ls.CIF_ID) customer_id,
                   c.cif_id AS cif_id,
                   LOAN_NUMBER ACCOUNT_NUMBER ,
                   'LAA' schm_type,
                   TO_CHAR (BANK_DETAILS) branch_Code,
                  nvl( TO_CHAR (s.SOL_ID),'030') sol_id,
                   TO_CHAR (ACCT_OPEN_DATE, 'dd-mm-yyyy') AS ACCT_OPEN_DATE
              FROM    MIGRATION.loan_details ls
                  left JOIN MIGRATION.sol_mapping s ON s.oldbankid = ls.BANK_DETAILS
                  join MIGRATION.CIF_ID c on c.customer_ID=ls.CIF_ID
                  
                  ) x)
                  

select count(*) from MIGRATION.customer_details

select count(*) from MIGRATION.loan_details where CIF_ID not in (select customer_id from MIGRATION.CUSTOMER_DETAILS)

select * from MIGRATION.loan_details 


select foracid from migration.foracid
group by foracid
having count(*)>1

select * from MIGRATION.foracid where sol_id is null

select * from MIGRATION.foracid where foracid is null

select * from MIGRATION.foracid where cif_id is null and acct_open_date is null or foracid is null


select count(*) from migration.foracid

select 18689-10215-8474 from dual

select distinct  loan_id from migration.loan_details --10215

select distinct  account_number from migration.loan_details --8474

select * from migration.foracid where SCHM_TYPE='LAA' and CIF_ID not in (select orgkey from crmuser.accounts);

select * from migration.foracid where SCHM_TYPE='LAA' and account_number not in (select account_number from migration.foracid where schm_type='SBA');