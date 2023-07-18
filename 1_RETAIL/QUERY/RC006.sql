SELECT distinct 
 cif_id CUST_ID,
cif_id AS ORGKEY
,'CELLPH' AS PHONEEMAILTYPE     --self
,'PHONE' AS PHONEOREMAIL 
,SUBSTR(TRIM( REGEXP_REPLACE(MOBILE_NUMBER,'[^[:print:][:space:]]|[`]|[~]|[!]|[@]|[#]|[$]|[%]|[*]|[|]|[<]|[>]|[?]|[=]|[;]|["]|[A-Z]|[a-z]|[+]','')),1,25) AS PHONENO  --new field added
,'01' AS PHONENOLOCALCODE  
,'01' AS PHONENOCITYCODE   
,'977' AS PHONENOCOUNTRYCODE 
,'' AS WORKEXTENSION
,'' AS EMAIL
,'' AS EMAILPALM
,'' AS URL
,'Y' AS PREFERREDFLAG  
,'' AS START_DATE
,'' AS END_DATE
,'' AS USERFIELD1
,'' AS USERFIELD2
,'' AS USERFIELD3
,'' AS DATE1
,'' AS DATE2
,'' AS DATE3
,'01' AS BANK_ID  
,'' AS TEMP
 FROM migration.customer_details C
join migration.CIF_ID cf on c.customer_id=cf.customer_id

union all


SELECT distinct 
cif_id CUST_ID,
cif_id AS ORGKEY
,'COMMEML' AS PHONEEMAILTYPE     --self
,'EMAIL' AS PHONEOREMAIL 
,'' AS PHONENO  --new field added
,'' AS PHONENOLOCALCODE  
,'' AS PHONENOCITYCODE   
,'' AS PHONENOCOUNTRYCODE 
,'' AS WORKEXTENSION
,replace(email_id,'|','') AS EMAIL
,'' AS EMAILPALM
,'' AS URL
,'Y' AS PREFERREDFLAG  
,'' AS START_DATE
,'' AS END_DATE
,'' AS USERFIELD1
,'' AS USERFIELD2
,'' AS USERFIELD3
,'' AS DATE1
,'' AS DATE2
,'' AS DATE3
,'01' AS BANK_ID  
,'' AS TEMP
 FROM migration.customer_details C
join migration.CIF_ID cf on c.customer_id=cf.customer_id



