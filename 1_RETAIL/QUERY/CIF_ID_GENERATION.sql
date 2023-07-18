select count(*) from MIGRATION.CUSTOMER_DETAILS --28084

select customer_id from migration.customer_details
group by customer_id
having count(*)>1

--1951
--863
--

edit migration.customer_details where customer_id='1951'

select count(distinct customer_id) from MIGRATION.CUSTOMER_DETAILS --28082

--drop table custom.CIF_ID
select customer_id from migration.CUSTOMER_DETAILS
where customer_id is null

select * from  migration.CUSTOMER_DETAILS where customer_id='1'

create table migration.CIF_ID as (
select distinct 'R'||lpad( (select REPLACE(max(orgkey),'R','') from crmuser.accounts)+1+row_number() over(order by customer_id),9,'0') as cif_id,customer_id as customer_id,
SOL_ID as SOL_ID
from (select distinct bank_id,customer_id from migration.CUSTOMER_DETAILS) cs
join migration.SOL_MAPPING s on cs.bank_id=s.oldbankid
)


select cif_id from migration.CIF_ID
group by cif_id
having count(*)>1

select customer_id from migration.CIF_ID
group by customer_id
having count(*)>1

select * from migration.cif_id where sol_id is null

select * from migration.CIF_ID

select count(*) from migration.CIF_ID --28082

create index test01 on migration.cif_id(cif_id)

create index test02 on migration.cif_id(customer_id)

create index test03 on migration.CUSTOMER_DETAILS(customer_id)

select * from migration.SOL_MAPPING



