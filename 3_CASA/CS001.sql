select distinct
f.foracid  AS foracid
,'W'  AS wtax_flg --mandatoryfield
,'P'     AS wtax_amount_scope_flg
,LPAD(TO_CHAR('5'),8)                AS wtax_pcnt
,''       AS wtax_floor_limit
,(select to_char(CIF_ID) from migration.cif_id x where x.customer_id=c.customer_id) AS CIF_id ------> new cif_id which is generated according to GIBL
,'0'  AS cust_cr_pref_pcnt 
,'0'       AS cust_dr_pref_pcnt
--,LPAD(TO_CHAR((select CASE WHEN id_cr_pref_pcnt BETWEEN 0 AND 1 THEN TO_CHAR('0'||id_cr_pref_pcnt) WHEN id_cr_pref_pcnt between 0 and -1 THEN TO_CHAR('-0'||id_cr_pref_pcnt) ELSE TO_CHAR(id_cr_pref_pcnt) END  from itc where itc.entity_id=g.acid and itc.int_tbl_code_srl_num=(select max(int_tbl_code_srl_num) from itc where itc.entity_id=g.acid) and entity_cre_flg='Y' and Del_Flg='N' and entity_type='ACCNT')),9)    AS id_cr_pref_pcnt     
,'0' AS id_cr_pref_pcnt
,'0'                              AS id_dr_pref_pcnt
,''                                         AS chnl_cr_pref_pcnt
,''                                         AS chnl_dr_pref_pcnt
,'N'                                        AS Pegged_flg
,'' AS peg_frequency_in_months
,'' AS peg_frequency_in_days
, 'D' AS int_freq_type_cr 
,'' AS int_freq_week_num_cr
,'' AS int_freq_week_day_cr
, '' as INT_FREQ_START_DD_CR
, 'N' AS int_freq_hldy_stat_cr
, to_char((select db_stat_date +30 from tbaadm.gct),'dd-mm-yyyy') AS next_int_run_date_cr  --add__gareko
, ''  AS int_freq_type_dr  
, '' AS int_freq_week_num_dr
, '' AS int_freq_week_day_dr
, '' AS int_freq_start_dd_dr
, '' AS int_freq_hldy_stat_dr
, '' AS next_int_run_date_dr
, '' AS ledg_num
,''  AS emp_id
,to_Char((select db_stat_date from tbaadm.gct),'dd-mm-yyyy') AS acct_opn_date
, '' AS Mode_of_oper_code
, (select gl_sub_head_code from migration.scheme_mapping gl where gl.sol_id=f.sol_id and schm_type='CAA') as Gl_sub_head_code --ask
,(select SCHM_CODE_NEW from migration.scheme_mapping gl where gl.sol_id=f.sol_id and schm_type='CAA')  as Schm_code        --ask
,'N'  AS Chq_alwd_flg
,'S' AS Pb_ps_code
,''     AS Frez_code 
,''     AS Frez_reason_code  
,''     AS free_text
,'A'    AS acct_Status		
, ''    AS free_code_1
, ''    AS free_code_2
, 'FREE3'    AS free_code_3  ---mandatory
, ''    AS free_code_4
, ''    AS free_code_5
, ''    AS free_code_6
, ''    AS free_code_7
, ''    AS free_code_8
, ''    AS free_code_9
, ''    AS free_code_10
,'ZEROC' AS int_tbl_code --mandatory
, ''    AS acct_loc_code
, 'NPR'    AS acct_crncy_code 
, to_Char(SOL_ID)    AS sol_id
, ''    AS acct_mgr_user_id 
, cust_first_name||case when nvl(cust_middle_name,' ') = ' ' then'' else ' 'end||cust_middle_name||' '||cust_last_name               AS acct_name    --ask
, 'N'                AS swift_allowed_flg
, ''       AS last_tran_date
, ''    AS last_any_tran_date 
, 'Y'                   AS xclude_for_comb_stmt 
, ''                    AS stmt_cust_id
,''                     AS chrg_level_code
, 'N'                   AS pbf_download_flg
, 'A'                   AS wtax_level_flg
, '' AS sanct_lim
, '' AS Drwng_power
,LPAD('',17)    AS dacc_lim_abs
, LPAD('',17)   AS dacc_lim_pcnt
, ''   AS max_alwd_advn_lim
,''   AS health_code
, ''    AS sanct_levl_code
, ''    AS sanct_ref_num
, ''    AS lim_sanct_date
, ''    AS lim_exp_date
, ''    AS lim_review_date
, ''    AS loan_paper_date
, ''    AS sanct_auth_code
, ''    AS Compound_date
, 'N'   AS daily_comp_int_flg
, ''    AS COMP_Date_flg
, 'N'   AS disc_rate_flg 
, ''    AS dummy
,''      AS acct_status_date	
, ''    AS iban_number
, ''    AS ias_code
, ''    AS channel_id
, ''    AS channel_level_code
, ''       AS int_suspense_amt 
, ''   AS Penal_int_Suspense_amt
, '' AS Chrge_off_flg
, '' AS pd_flg
, '' AS pd_xfer_Date
, '' AS Chrge_off_date
, '' AS Chrge_off_principal
, '' AS Pending_interest
, '' AS Principal_recovery
, '' AS interest_recovery
, '' AS Charge_off_type
, '' AS master_acct_num
, '' AS ps_diff_freq_rel_party_flg
, '' AS swift_diff_freq_rel_party_flg
, '' AS add_type
, '' AS Phone_type
, '' AS Email_type
, '' AS Alternate_Acct_Name                                    
, '' AS Interest_Rate_Period_Months                            
, '' AS Interest_Rate_Period_Days                              
, '' AS Interpolation_Method                                   
, '' AS Is_Acct_hedged_Flg                                     
, '' AS Used_for_netting_off_flg                               
, '' AS Security_Indicator                                     
, '' AS Debt_Security                                       
, '' AS Security_Code                                         
, '' AS Debit_Interest_Method                                  
, '' AS serv_chrg_coll_flg                                     
, '' AS Last_purge_date                                        
, '' AS Total_profit_amt                                       
, '' AS Minimum_age_not_met_amt                                
, '' AS Broken_period_profit_paid_flg                          
, '' AS Broken_period_profit_amt                               
, '' AS Profit_to_be_recovered                                 
, '' AS Profit_distributed_upto_date                           
, '' AS Next_profit_distributed_date                           
, '' AS Acc_amt_till_int_calc_date_cr                        
, '' AS Unclaim_status                                        
, '' AS Unclaim_status_date                                    
, '' AS Gl_Sub_Head_Code_1
from migration.loan_details l
join migration.customer_details c on l.cif_id  = c.customer_id and l.account_number  = c.account_number
join migration.foracid f on f.account_number=l.account_number
where schm_Type='SBA'
--and foracid not in (select foracid from tbaadm.gam where schm_Type='CAA')
--and sol_id='001'
--and foracid='0300000056420001'

--select * from custom.foracid
--select * from migration.scheme_mapping