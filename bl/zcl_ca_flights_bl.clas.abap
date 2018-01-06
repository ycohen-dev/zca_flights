class ZCL_CA_FLIGHTS_BL definition
  public
  final
  create public .

public section.

  interfaces ZIF_CA_FLIGHTS_BL .

  methods CONSTRUCTOR
    importing
      !IO_FLIGHTS_DB type ref to ZIF_CA_FLIGHTS_DB .
protected section.
private section.

  data MO_DATA_ACCESS type ref to ZIF_CA_FLIGHTS_DB .
ENDCLASS.



CLASS ZCL_CA_FLIGHTS_BL IMPLEMENTATION.


  method CONSTRUCTOR.

    me->mo_data_access = io_flights_db.

  endmethod.


  method ZIF_CA_FLIGHTS_BL~CREATE_NEW_FLIGHT.
  endmethod.


  method ZIF_CA_FLIGHTS_BL~GET_AIRLINES.

    rt_airlines = mo_data_access->get_airlines(
        ir_airline_code = ir_airline_code
    ).

  endmethod.


  method ZIF_CA_FLIGHTS_BL~GET_FLIGHTS.

    rt_flights = mo_data_access->get_flights(
                 ir_airline_code  = ir_airline_code
                 ir_flight_number = ir_flight_number
                 ir_flight_date   = ir_flight_date
             ).

  endmethod.


  method ZIF_CA_FLIGHTS_BL~UPDATE_FLIGHT_PRICE.
  endmethod.
ENDCLASS.
