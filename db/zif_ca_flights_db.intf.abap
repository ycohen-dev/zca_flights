INTERFACE zif_ca_flights_db
  PUBLIC .


  METHODS get_flights
    RETURNING
      VALUE(rt_flights) TYPE zca_flight_tt .
  METHODS get_airlines .
  METHODS create_flight
    RAISING
      zcx_flights_db_error .
  METHODS update_flight
    RAISING
      zcx_flights_db_error .


ENDINTERFACE.
