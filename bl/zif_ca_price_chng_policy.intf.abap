interface ZIF_CA_PRICE_CHNG_POLICY
  public .


  methods VALIDATE_FLIGHT_PRICE
    importing
      !IS_FLIGHT_DATA type ZCA_FLIGHT_ST
      !IV_OLD_COST type ZCA_FLIGHT_ST-FLIGHT_COST optional
      !IV_NEW_COST type ZCA_FLIGHT_ST-FLIGHT_COST
    returning
      value(RS_BAPIRET_MESSAGE) type BAPIRET2 .
endinterface.
