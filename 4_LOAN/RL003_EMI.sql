SELECT 
 F.FORACID    AS foracid     
, 'EIDEM'  AS flow_id                    
,case when FLOW_START_DATE<=(select db_stat_date from tbaadm.gct) then (select to_Char(db_stat_date+1,'dd-mm-yyyy') from tbaadm.gct)
else to_char(FLOW_START_DATE,'DD-MM-yyyy') end AS flow_start_date            
,'M'  AS lr_freq_type         --NEED TO BE MAPPED PROPERLY AS D,M,Q,H,Y       
, ''  AS lr_freq_week_num           
, ''  AS lr_freq_week_day           
,LPAD(case when FLOW_START_DATE<=(select db_stat_date from tbaadm.gct) then (select to_Char(db_stat_date+1,'dd-mm-yyyy') from tbaadm.gct)
else to_char(FLOW_START_DATE,'DD-MM-yyyy') end,2) AS lr_freq_start_dd          
, ''  AS lr_freq_months           
, ''  AS lr_freq_days
, 'P' AS lr_freq_hldy_stat --DEFAULT VALUE P VALUE NEEDED
,to_char(num_of_flows)  AS num_of_flows           
,CASE WHEN NVL(DEMAND_AMOUNT,0) = 0 THEN LPAD('0.01',17) ELSE LPAD(DEMAND_AMOUNT,17) END AS flow_amt                     
, ''  AS instlmnt_pcnt              
, to_char(NUM_OF_DEMAND)  AS num_of_dmds               
,'' AS next_dmd_date  
,''  AS next_int_dmd_date            
,''     AS lr_int_freq_type       
, ''  AS lr_int_freq_week_num       
, ''  AS lr_int_freq_week_day     
,'' AS lr_int_freq_start_dd         
, ''  AS lr_int_freq_months           
, ''  AS lr_int_freq_days             
, 'P' AS lr_int_freq_hldy_stat        
,''    AS instlmnt_ind           
FROM MIGRATION.LOAN_DETAILS L
JOIN MIGRATION.FORACID F ON F.ACCOUNT_NUMBER  = L.LOAN_NUMBER
join MIGRATION.EMI_DETAILS_FONENXT ei on EI.ACCOUNT_NUMBER=L.ACCount_number
--join MIGRATION.loan_upl_details upl on upl.loan_number=L.LOAN_NUMBER
WHERE UPPER(SCHM_CODE)  != '1 MONTH' 
and foracid not in (select foracid from tbaadm.gam g join tbaadm.lrs l on g.acid=l.acid)
--and foracid='0040000163530002'


--select * from MIGRATION.EMI_DETAILS_FONENXT

