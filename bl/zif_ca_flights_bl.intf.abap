interface ZIF_CA_FLIGHTS_BL
  public .


  methods GET_AIRLINES
    importing
      !IR_AIRLINE_CODE type ZIF_CA_FLIGHTS_DB=>TR_AIRLINE_CODE optional
    returning
      value(RT_AIRLINES) type ZCA_AIRLINE_TT .
  methods GET_FLIGHTS
    importing
      !IR_AIRLINE_CODE type ZIF_CA_FLIGHTS_DB=>TR_AIRLINE_CODE optional
      !IR_FLIGHT_NUMBER type ZIF_CA_FLIGHTS_DB=>TR_FLIGHT_NUMBER optional
      !IR_FLIGHT_DATE type ZIF_CA_FLIGHTS_DB=>TR_FLIGHT_DATE optional
    returning
      value(RT_FLIGHTS) type ZCA_FLIGHT_TT .
  methods UPDATE_FLIGHT_PRICE
    importing
      !IV_AIRLINE_CODE type ZCA_FLIGHT_ST-AIRLINE_CODE
      !IV_FLIGHT_NUMBER type ZCA_FLIGHT_ST-FLIGHT_NUMBER
      !IV_FLIGHT_DATE type ZCA_FLIGHT_ST-FLIGHT_DATE
      !IV_NEW_COST type ZCA_FLIGHT_ST-FLIGHT_COST
    returning
      value(RT_BAPIRET_MESSAGES) type BAPIRET2_T
    raising
      ZCX_FLIGHTS_BL_ERROR .
  methods CREATE_NEW_FLIGHT
    importing
      !IS_FLIGHT_DATA type ZCA_FLIGHT_ST
    returning
      value(RT_BAPIRET_MESSAGES) type BAPIRET2_T
    raising
      ZCX_FLIGHTS_BL_ERROR .
endinterface.
