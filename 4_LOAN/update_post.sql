select 'update tbaadm.gac set FREE_TEXT_6='||''''||branch_id||''''||', FREE_TEXT_7='||''''||branch_name||''''||', FREE_TEXT_8='||''''||bank_details||''''|| ' where acid=(select acid from tbaadm.gam where foracid='||''''|| foracid||''''||');'  from (
select g.foracid,to_char(branch_id ) branch_id, branch_name,to_char(bank_details) bank_details from tbaadm.gam g join migration.foracid f on g.foracid=f.foracid
join tbaadm.gac gc on g.acid=gc.acid 
join MIGRATION.LOAN_DETAILS l on l.loan_number=F.ACCOUNT_NUMBER

union all

select distinct f.foracid,l.branch_code,l.branch_name,l.bank_id from tbaadm.gam g join migration.foracid f on g.foracid=f.foracid
join tbaadm.gac gc on g.acid=gc.acid 
join MIGRATION.CUSTOMER_DETAILS l on l.account_number=F.ACCOUNT_NUMBER
)x

update tbaadm.gam set pb_ps_code='N' where schm_type in ('LAA','SBA') 


update tbaadm.aas set pass_sheet_flg='N', mode_of_despatch=''  where acid in (select acid from tbaadm.gam where schm_type in ('LAA','SBA'))


update tbaadm.ast set PS_REQD_FLG='N',PS_FREQ_TYPE='' where acid in (select acid from tbaadm.gam where schm_type in ('LAA','SBA'))