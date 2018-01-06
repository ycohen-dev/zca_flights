INTERFACE zif_ca_flights_db
  PUBLIC .

  TYPES: tr_airline_code TYPE RANGE OF zca_airline_st-airline_code,
         tr_flight_number TYPE RANGE OF zca_flight_st-flight_number,
         tr_flight_date TYPE RANGE OF zca_flight_st-flight_date.


  METHODS get_flights
    IMPORTING ir_airline_code TYPE tr_airline_code OPTIONAL
              ir_flight_number TYPE tr_flight_number OPTIONAL
              ir_flight_date TYPE tr_flight_date OPTIONAL
    RETURNING
      VALUE(rt_flights) TYPE zca_flight_tt .

  METHODS get_airlines
    IMPORTING ir_airline_code TYPE tr_airline_code OPTIONAL
    RETURNING
      VALUE(rt_airlines) TYPE zca_airline_tt.

  METHODS create_flight
    IMPORTING iv_airline_code TYPE zca_flight_st-airline_code
              iv_flight_number TYPE zca_flight_st-flight_number
              iv_flight_date TYPE zca_flight_st-flight_date
              iv_flight_cost TYPE zca_flight_st-flight_cost
              iv_flight_currency TYPE zca_flight_st-flight_curr
              iv_plane_type TYPE zca_flight_st-plane_type
    RAISING
      zcx_flights_db_error .

  METHODS update_flight
    IMPORTING iv_airline_code TYPE zca_flight_st-airline_code
              iv_flight_number TYPE zca_flight_st-flight_number
              iv_flight_date TYPE zca_flight_st-flight_date
              iv_flight_cost TYPE zca_flight_st-flight_cost
              iv_flight_currency TYPE zca_flight_st-flight_curr
    RAISING
      zcx_flights_db_error .


ENDINTERFACE.
