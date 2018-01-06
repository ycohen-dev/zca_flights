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
  endmethod.


  method ZIF_CA_FLIGHTS_BL~GET_FLIGHTS.
  endmethod.


  method ZIF_CA_FLIGHTS_BL~UPDATE_FLIGHT_PRICE.
  endmethod.
ENDCLASS.
