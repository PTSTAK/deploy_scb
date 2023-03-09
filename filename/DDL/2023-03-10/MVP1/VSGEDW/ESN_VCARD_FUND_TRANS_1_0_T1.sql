CREATE OR REPLACE VIEW P1VSGEDW.ESN_VCARD_FUND_TRANS_1_0_T1 (
  EDW_RECORD_NO,
  USERID,
  CARD_NO,
  CARD_MASK,
  TRANS_TYPE,
  TRANS_DESC,
  TRANS_DATE,
  TRANS_TIME,
  AMOUNT,
  LINKED_ACCOUNT,
  AUTHORIZATION_CODE,
  AVAILABLE_AMOUNT,
  PREVIOUS_AMOUNT,
  FEE,
  TRACE_NO,
  CHANNEL,
  TRANS_ID,
  FEE_TYPE,
  START_DT,
  END_DT,
  RECORD_DELETED_FLAG,
  CTL_ID,
  INS_PROC_NAME,
  INS_TXF_BATCHID,
  UPD_PROC_NAME,
  UPD_TXF_BATCHID)
AS SELECT * FROM P1DSGEDW.ESN_VCARD_FUND_TRANS_1_0_T1
