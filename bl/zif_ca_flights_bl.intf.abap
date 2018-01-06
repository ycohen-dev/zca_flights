interface ZIF_CA_FLIGHTS_BL
  public .


  methods GET_AIRLINES
    importing
      !IR_AIRLINE_CODE type ZIF_CA_FLIGHTS_DB=>TR_AIRLINE_CODE
    returning
      value(RT_AIRLINES) type ZCA_AIRLINE_TT .
  methods GET_FLIGHTS
    importing
      !IR_AIRLINE_CODE type ZIF_CA_FLIGHTS_DB=>TR_AIRLINE_CODE
      !IR_FLIGHT_NUMBER type ZIF_CA_FLIGHTS_DB=>TR_FLIGHT_NUMBER
      !IR_FLIGHT_DATE type ZIF_CA_FLIGHTS_DB=>TR_FLIGHT_DATE
    returning
      value(RT_FLIGHTS) type ZCA_FLIGHT_TT .
  methods UPDATE_FLIGHT_PRICE
    importing
      !IS_FLIGHT_DATA type ZCA_FLIGHT_ST
      !IO_MESSAGE_CONTAINER type ref to /IWFND/IF_MESSAGE_CONTAINER
    raising
      ZCX_FLIGHTS_BL_ERROR .
  methods CREATE_NEW_FLIGHT
    importing
      !IS_FLIGHT_DATA type ZCA_FLIGHT_ST
      !IO_MESSAGE_CONTAINER type ref to /IWFND/IF_MESSAGE_CONTAINER
    raising
      ZCX_FLIGHTS_BL_ERROR .
endinterface.
