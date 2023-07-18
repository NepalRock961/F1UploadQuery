select x.*, case when flow_start_date1<(select db_stat_date+1 from tbaadm.gct) then (select to_char(db_stat_date+1,'dd-mm-yyyy') from tbaadm.gct)
else to_char(to_date(flow_start_date1,'dd-MON-yyyy'),'dd-mm-yyyy') end flow_start_date from (
SELECT 
 F.FORACID    AS foracid       --NEED TO MAP WITH FINACLE FORACID             
, 'PRDEM'    flow_id    
,case when LIMIT_EXP_DATE < (
    case when L.ACCT_OPEN_DATE>(select db_stat_date from tbaadm.gct) then (select db_stat_date from tbaadm.gct)
    else L.ACCT_OPEN_DATE end   ) then '30-DEC-2099' 
    else to_char(LIMIT_EXP_DATE,'dd-mON-yyyy') END AS flow_start_date1           
, 'B' lr_freq_type         --NEED TO BE MAPPED PROPERLY AS D,M,Q,H,Y       
, '' lr_freq_week_num           
, '' lr_freq_week_day           
, ''  lr_freq_start_dd          
, '' lr_freq_months           
, ''  lr_freq_days
, 'P' lr_freq_hldy_stat --DEFAULT VALUE P VALUE NEEDED
,LPAD('1',3) num_of_flows           
,CASE WHEN NVL(PRI_OUTSTANDING_AMT,0) = 0 THEN LPAD('0.01',17) ELSE LPAD(abs(PRI_OUTSTANDING_AMT),17) END AS  flow_amt                     
,'' instlmnt_pcnt              
, '0' num_of_dmds               
,'' AS next_dmd_date  
, '' next_int_dmd_date            
, '' lr_int_freq_type       
, '' lr_int_freq_week_num       
, '' lr_int_freq_week_day     
, '' lr_int_freq_start_dd         
, '' lr_int_freq_months           
, '' lr_int_freq_days             
, '' lr_int_freq_hldy_stat        
, '' instlmnt_ind  
FROM MIGRATION.LOAN_DETAILS L
JOIN MIGRATION.FORACID F ON F.ACCOUNT_NUMBER  = L.LOAN_NUMBER
--join MIGRATION.loan_upl_details upl on upl.loan_number=L.LOAN_NUMBER
WHERE UPPER(SCHM_CODE)  = '1 MONTH' 


union all
select 
 F.FORACID    AS foracid     ,             
 'INDEM'  AS flow_id                    
, case when LIMIT_EXP_DATE < (
    case when L.ACCT_OPEN_DATE>(select db_stat_date from tbaadm.gct) then (select db_stat_date from tbaadm.gct)
    else L.ACCT_OPEN_DATE end   ) then '30-DEC-2099' 
    else to_char(LIMIT_EXP_DATE,'DD-mON-YYYY') END  AS flow_start_date1            
, 'Q'  AS lr_freq_type  --DEFFRENT TYPE OF VALUE NEED TO BE MAPPED             
, ''  AS lr_freq_week_num           
, '' AS lr_freq_week_day           
, LPAD(EXTRACT(DAY FROM TO_DATE(TO_CHAR(LIMIT_EXP_DATE),'DD-MM-YYYY')),2,'0')  AS lr_freq_start_dd          
, ''  AS lr_freq_months           
, ''  AS lr_freq_days
, 'P' AS lr_freq_hldy_stat 
, LPAD('0',3) AS num_of_flows           
,  LPAD(to_char('0.00'),17)    AS flow_amt         --FLOWAMT INCASE OF INDEM WILL BE 0.00 SYSTEM WILL GENERATE THE INDEM AMT            
, ''  AS instlmnt_pcnt              
,'' AS num_of_dmds               
, '' next_dmd_date  
,''  AS next_int_dmd_date            
, '' AS lr_int_freq_type       
, ''  AS lr_int_freq_week_num       
, ''  AS lr_int_freq_week_day     
,'' AS lr_int_freq_start_dd         
, ''  AS lr_int_freq_months           
, ''  AS lr_int_freq_days             
, 'P' AS lr_int_freq_hldy_stat        
,  '' instlmnt_ind       
FROM MIGRATION.LOAN_DETAILS L
JOIN MIGRATION.FORACID F ON F.ACCOUNT_NUMBER  = L.LOAN_NUMBER
--join MIGRATION.loan_upl_details upl on upl.loan_number=L.LOAN_NUMBER
WHERE UPPER(SCHM_CODE)  = '1 MONTH' 
)x --where foracid='0310000287840002'

order by foracid,flow_id desc


--select * from MIGRATION.LOAN_DETAILS

