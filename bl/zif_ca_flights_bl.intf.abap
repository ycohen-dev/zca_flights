interface ZIF_CA_FLIGHTS_BL
  public .


  methods GET_AIRLINES .
  methods GET_FLIGHTS .
  methods UPDATE_FLIGHT_PRICE
    raising
      ZCX_FLIGHTS_BL_ERROR .
  methods CREATE_NEW_FLIGHT .
endinterface.
