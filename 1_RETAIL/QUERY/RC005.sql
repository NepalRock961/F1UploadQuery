
SELECT distinct
cif_id AS CUST_ID,
cif_id AS ORGKEY
,'' AS DOCDUEDATE
,''  AS DOCRECEIVEDDATE  
,''   AS DOCEXPIRYDATE  --KYC_INDIVIDUAL_DETAILS
,'N' AS DOCDELFLG    
,'' AS DOCREMARKS
,'Y' AS SCANNED  
,'NOTA' AS DOCCODE
,'NOT AVAILABLE' AS DOCDESCR
,'NOTA' AS REFERENCENUMBER
,'' AS TYPE    
,'Y' AS ISMANDATORY
,'N' AS SCANREQUIRED  
,'' AS ROLE
,'RETAIL DOCODE' AS DOCTYPECODE  
,'RETAIL DOCUMENT CODE' AS DOCTYPEDESCR  
,'' AS MINDOCSREQD
,'' AS WAIVEDORDEFEREDDATE
,'NOTA' AS COUNTRYOFISSUE
,'NOTA' AS PLACEOFISSUE
,to_char((select db_stat_date-1 from tbaadm.gct),'dd-mon-yyyy') AS DOCISSUEDATE  --EMBSY_ISSUE_DATE OR DB DATE 
,'IDTYPER9' AS IDENTIFICATIONTYPE 
,replace(cif_id,'R','') AS CORE_CUST_ID
,'Y' AS IS_DOCUMENT_VERIFIED 
,'' AS BEN_OWN_KEY
,'01' AS BANK_ID
,'' AS DOCTYPEDESCR_ALT1
,'' AS DOCDESCR_ALT1
,'' AS STATUS  
 FROM migration.customer_details C
join migration.CIF_ID cf on c.customer_id=cf.customer_id
order by cif_id
