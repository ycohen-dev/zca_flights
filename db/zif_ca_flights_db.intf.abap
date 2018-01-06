interface ZIF_CA_FLIGHTS_DB
  public .


  types:
    tr_airline_code TYPE RANGE OF zca_airline_st-airline_code .
  types:
    tr_flight_number TYPE RANGE OF zca_flight_st-flight_number .
  types:
    tr_flight_date TYPE RANGE OF zca_flight_st-flight_date .

  methods GET_FLIGHTS
    importing
      !IR_AIRLINE_CODE type TR_AIRLINE_CODE optional
      !IR_FLIGHT_NUMBER type TR_FLIGHT_NUMBER optional
      !IR_FLIGHT_DATE type TR_FLIGHT_DATE optional
    returning
      value(RT_FLIGHTS) type ZCA_FLIGHT_TT .
  methods GET_AIRLINES
    importing
      !IR_AIRLINE_CODE type TR_AIRLINE_CODE optional
    returning
      value(RT_AIRLINES) type ZCA_AIRLINE_TT .
  methods CREATE_OR_UPD_FLIGHT
    importing
      !IV_AIRLINE_CODE type ZCA_FLIGHT_ST-AIRLINE_CODE
      !IV_FLIGHT_NUMBER type ZCA_FLIGHT_ST-FLIGHT_NUMBER
      !IV_FLIGHT_DATE type ZCA_FLIGHT_ST-FLIGHT_DATE
      !IV_FLIGHT_COST type ZCA_FLIGHT_ST-FLIGHT_COST
      !IV_FLIGHT_CURRENCY type ZCA_FLIGHT_ST-FLIGHT_CURR
      !IV_PLANE_TYPE type ZCA_FLIGHT_ST-PLANE_TYPE
    raising
      ZCX_FLIGHTS_DB_ERROR .
endinterface.
