CREATE OR REPLACE VIEW P1VEULQ.VLQ_05_GL_ACCT_SEGMENT (
  AC_CODE,
  NAME_ENG,
  NAME_TH,
  LST_DATETIME)
AS SELECT 
CAST(GL_ACCT.GL_ACCOUNT_CODE_VAL    AS CHAR (5))      AS AC_CODE
,CAST(GL_ACCT.GL_MAIN_ACCOUNT_NAME AS CHAR (180))  AS NAME_ENG
,CAST(GL_ACCT.GL_MAIN_ACCOUNT_THAI_NAME   AS CHAR (180))   AS NAME_TH
,( DATE_FORMAT(GL_ACCT.START_DT , 'yyyy-MM-dd')) AS  LST_DATETIME

FROM P1VTTEDW.GL_MAIN_ACCT_SET_OF_BOOKS_XREF AS GL_MA_SOB_REF

CROSS JOIN P1VTPLQ.VLQ_BUSINESSDATE_D AS CB 

INNER JOIN P1VTTEDW.GL_MAIN_ACCOUNT AS GL_ACCT
ON GL_MA_SOB_REF.GL_MAIN_ACCOUNT_NUM = GL_ACCT.GL_MAIN_ACCOUNT_NUM
 --> Add 2010-06-18 : UR no.R53040049-01 [EDW Performance Tuning -Set #11 (for LQ)]
 AND GL_ACCT.CTL_ID ='006'
 --> Add 2010-06-18 : UR no.R53040049-01 [EDW Performance Tuning -Set #11 (for LQ)]

INNER JOIN P1VUTEDW.BKEY_GL_MAIN_ACCT_NUM AS BK_GL_MAIN
ON GL_ACCT.GL_MAIN_ACCOUNT_NUM = BK_GL_MAIN.EDW_KEY
AND SUBSTR(BK_GL_MAIN.SOURCE_KEY,0,INSTR(BK_GL_MAIN.SOURCE_KEY,'_')-1) = '0000000000000000062017'

INNER JOIN 
(
SELECT
OLD_SEGMENT6_ACCOUNT_CODE
FROM P1VSTEDW.CSFMS_GLCOAMAP_1_0
GROUP BY 1
) AS GLCOAMAP
 ON GL_ACCT.GL_ACCOUNT_CODE_VAL = GLCOAMAP.OLD_SEGMENT6_ACCOUNT_CODE              


WHERE GL_MA_SOB_REF.SET_OF_BOOKS_CD = 1
 AND GL_ACCT.GL_MAIN_ACCOUNT_CATEGORY_CD IN (1,3)
 AND GL_MA_SOB_REF.RECORD_DELETED_FLAG = 0
 AND GL_ACCT.RECORD_DELETED_FLAG = 0
 AND CB.BUSINESSDATE BETWEEN GL_MA_SOB_REF.START_DT AND GL_MA_SOB_REF.END_DT
 AND CB.BUSINESSDATE BETWEEN GL_ACCT.START_DT AND GL_ACCT.END_DT
 --> Add 2010-06-18 : UR no.R53040049-01 [EDW Performance Tuning -Set #11 (for LQ)]
 AND GL_MA_SOB_REF.CTL_ID ='006'
